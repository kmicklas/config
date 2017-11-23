{ config, pkgs, ... }:

{
  imports = [ ./reflex.nix ];

  time.timeZone = "America/New_York";

  nix.readOnlyStore = true;

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

  security.sudo.wheelNeedsPassword = false;

  programs.fish.enable = true;
  users.defaultUserShell = "/run/current-system/sw/bin/fish";

  users.extraUsers.kmicklas = import ./kmicklas;
}
