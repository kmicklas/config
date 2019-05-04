{ config, pkgs, lib, ... }:

{
  imports = [
    ./reflex.nix
  ] ++ lib.optionals (builtins.pathExists ../../../private/nix) [
    ../../../private/nix
  ];

  time.timeZone = "America/New_York";

  nix = {
    readOnlyStore = true;
    autoOptimiseStore = true;
    nixPath = let
      nixpkgs = builtins.toPath ../../../dep/nixpkgs;
    in [
      ("nixos=" + nixpkgs)
      ("nixpkgs=" + nixpkgs)
      "nixos-config=/etc/nixos/configuration.nix"
    ];
  };

  i18n.defaultLocale = "pt_BR.UTF-8";

  environment.systemPackages = builtins.concatLists [
    (import ./packages.nix pkgs)
    # TODO: Consider using nixpkgs version once it's more stable/up-to-date.
    [ (import ../../../dep/home-manager { inherit pkgs; }).home-manager ]
  ];

  nixpkgs.config.allowUnfree = true;

  services.openssh = {
    enable = true;
    forwardX11 = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };

  services.postgresql.enable = true;

  security.sudo.wheelNeedsPassword = false;

  programs.fish.enable = true;
  users.defaultUserShell = "/run/current-system/sw/bin/fish";

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [
        "dotenv"
        "git"
        "man"
      ];
    };
  };

  services.emacs = {
    enable = true;
    defaultEditor = true;
  };

  # Theoretically will reduce hangs during nix-builds.
  services.fstrim.enable = true;

  users.extraUsers.kmicklas = import ./kmicklas;
}
