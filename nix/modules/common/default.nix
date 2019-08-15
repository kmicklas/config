{ config, pkgs, lib, ... }:

{
  imports = [
    ./reflex.nix
  ];

  environment.systemPackages = import ./packages.nix pkgs;

  time.timeZone = "America/New_York";

  nix.readOnlyStore = true;
  nix.autoOptimiseStore = true;
  nix.nixPath = let
    nixpkgs = builtins.toPath ../../../dep/nixpkgs;
  in [
    ("nixos=" + nixpkgs)
    ("nixpkgs=" + nixpkgs)
  ];

  boot.tmpOnTmpfs = true;

  i18n.defaultLocale = "pt_BR.UTF-8";
  i18n.consoleFont = "latarcyrheb-sun32";

  nixpkgs.config.allowUnfree = true;

  services.openssh.enable = true;
  services.openssh.forwardX11 = true;
  services.openssh.permitRootLogin = "no";
  services.openssh.passwordAuthentication = false;

  services.postgresql.enable = true;

  security.sudo.wheelNeedsPassword = false;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Theoretically will reduce hangs during nix-builds.
  services.fstrim.enable = true;

  users.users.kmicklas = import ./kmicklas;
}
