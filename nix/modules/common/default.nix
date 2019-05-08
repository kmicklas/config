{ config, pkgs, lib, ... }:

{
  imports = [
    ./reflex.nix
  ] ++ lib.optionals (builtins.pathExists ../../../private/nix) [
    ../../../private/nix
  ];

  environment.systemPackages = import ./packages.nix pkgs;

  time.timeZone = "America/New_York";

  nix = {
    readOnlyStore = true;
    autoOptimiseStore = true;
    nixPath = let
      nixpkgs = builtins.toPath ../../../dep/nixpkgs;
    in [
      ("nixos=" + nixpkgs)
      ("nixpkgs=" + nixpkgs)
    ];
  };

  i18n.defaultLocale = "pt_BR.UTF-8";

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
