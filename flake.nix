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
      username = "kmicklas";
      hosts = [
        {
          name = "meitan";
          system = "x86_64-linux";
        }
        {
          name = "pej";
          system = "x86_64-linux";
        }
      ];
      systems = [ "x86_64-linux" ];
      nixpkgsPath = nixpkgs.outPath;

      mkPkgs = repo: system:
        import repo {
          inherit system;
          config = import ./dotfiles/config/nixpkgs/config.nix;
        };

      forAllSystems = f:
        nixpkgs.lib.genAttrs systems (system: f (mkPkgs nixpkgs system));

      mkHome = { system, modules, extraSpecialArgs ? { }, }:
        let pkgs = mkPkgs nixpkgs system;
        in home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          inherit modules;

          extraSpecialArgs = {
            inherit inputs;
            inherit nixpkgsPath;
            pkgs-unstable = mkPkgs nixpkgs-unstable system;
          } // extraSpecialArgs;
        };

      mkNixos = { name, system }:
        let pkgs = mkPkgs nixpkgs system;
        in nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit inputs;
            inherit nixpkgsPath;
            pkgs-unstable = mkPkgs nixpkgs-unstable system;
          };

          modules = [ (./hosts + "/${name}/default.nix") ];
        };

    in {
      formatter = forAllSystems (pkgs: pkgs.nixfmt-classic);

      lib = { inherit mkHome; };

      homeConfigurations = nixpkgs.lib.listToAttrs (map (host: {
        name = "${username}@${host.name}";
        value = mkHome {
          inherit (host) system;
          modules = [ (./hosts + "/${host.name}/${username}/home.nix") ];
        };
      }) hosts);

      nixosConfigurations = nixpkgs.lib.listToAttrs (map (host: {
        name = host.name;
        value = mkNixos host;
      }) hosts);
    };
}
