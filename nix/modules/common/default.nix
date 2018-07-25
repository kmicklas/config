{ config, pkgs, lib, ... }:

{
  imports = [
    ./reflex.nix
  ] ++ lib.optionals (builtins.pathExists ../../../private/nix) [
    ../../../private/nix
  ];

  time.timeZone = "America/New_York";

  nix.readOnlyStore = true;

  i18n = {
    defaultLocale = "pt_BR.UTF-8";
  };

  environment.systemPackages = (import ./packages.nix) pkgs;

  nixpkgs.config.allowUnfree = true;

  services.openssh = {
    enable = true;
    forwardX11 = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };

  services.postgresql.enable = true;

  virtualisation.docker.enable = true;

  security.sudo.wheelNeedsPassword = false;

  programs.fish.enable = true;
  users.defaultUserShell = "/run/current-system/sw/bin/fish";

  services.emacs = {
    enable = true;
    defaultEditor = true;
  };

  services.statsd.enable = true;

  users.extraUsers.kmicklas = import ./kmicklas;
}
