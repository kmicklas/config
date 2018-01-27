{ config, pkgs, ... }:

{
  imports = [ ./reflex.nix ];

  time.timeZone = "America/New_York";

  nix.readOnlyStore = true;
  nix.package = pkgs.nixUnstable;

  networking.firewall.allowedTCPPorts = [ 22 9000 9001 ];
  networking.firewall.allowedUDPPorts = [ 22      9001 ];

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

  users.extraUsers.kmicklas = import ./kmicklas;
}
