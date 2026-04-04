{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flakes
    helix = {
      url = "github:kmicklas/helix/personal-fork";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Non-flakes
    git-global-status = {
      url = "github:kmicklas/git-global-status/main";
      flake = false;
    };
    mpv-sub-scripts = {
      url = "github:Ben-Kerman/mpv-sub-scripts/master";
      flake = false;
    };
    mud = {
      url = "https://www.dropbox.com/s/2669wx4az2jt62t/Mud.jpg";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      nixpkgsPath = nixpkgs.outPath;
      nixpkgsConfig = {
        allowBroken = true;
        allowUnfree = true;
      };

      listDirectories = path:
        builtins.attrNames
        (nixpkgs.lib.filterAttrs (_: type: type == "directory")
          (builtins.readDir path));
      optionalPath = path: if builtins.pathExists path then path else null;

      hostRoot = ./hosts;
      hostNames = listDirectories hostRoot;
      hosts = map (name: {
        inherit name;
        system = import (hostRoot + "/${name}/system.nix");
      }) hostNames;
      hostUsers = host:
        let usersPath = optionalPath (hostRoot + "/${host.name}/users");
        in if usersPath == null then [ ] else listDirectories usersPath;

      mkPkgs = repo: system:
        import repo {
          inherit system;
          config = nixpkgsConfig;
        };

      forAllSystems = f:
        nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed
        (system: f (mkPkgs nixpkgs system));

      mkHome = { system, modules, extraSpecialArgs ? { }, }:
        let pkgs = mkPkgs nixpkgs system;
        in home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          inherit modules;

          extraSpecialArgs = {
            inherit inputs;
            inherit nixpkgsConfig;
            inherit nixpkgsPath;
            pkgs-unstable = mkPkgs nixpkgs-unstable system;
          } // extraSpecialArgs;
        };

      mkNixos = { name, system }:
        nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit inputs;
            inherit nixpkgsConfig;
            inherit nixpkgsPath;
            pkgs-unstable = mkPkgs nixpkgs-unstable system;
          };

          modules = [ (./hosts + "/${name}/default.nix") ];
        };

      mkHomeEntries = host: username:
        let
          homePath = optionalPath
            (hostRoot + "/${host.name}/users/${username}/home.nix");
        in if homePath == null then
          [ ]
        else [{
          name = "${username}@${host.name}";
          value = mkHome {
            inherit (host) system;
            modules = [ homePath ];
          };
        }];

    in {
      formatter = forAllSystems (pkgs: pkgs.nixfmt-classic);

      lib = { inherit mkHome; };

      homeConfigurations = nixpkgs.lib.listToAttrs (nixpkgs.lib.concatMap
        (host: nixpkgs.lib.concatMap (mkHomeEntries host) (hostUsers host))
        hosts);

      nixosConfigurations = nixpkgs.lib.listToAttrs (map (host: {
        name = host.name;
        value = mkNixos host;
      }) hosts);
    };
}
