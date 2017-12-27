{ config, pkgs, ... }:

{
  hardware = {
    bluetooth.enable = true;
    pulseaudio.enable = true;
  };

  environment.systemPackages = (import ./packages.nix) pkgs;
  fonts = (import ./fonts.nix) pkgs;

  networking.networkmanager.enable = true;

  services.printing.enable = true;

  services.xserver = {
    enable = true;
    layout = "us";
    enableCtrlAltBackspace = true;

    displayManager = {
      sessionCommands = ''
        xscreensaver -no-splash &
        albert &
        compton -b --inactive-dim 0.05 -f -D 5
      '';
    };

    windowManager = {
      xmonad.enable = true;
      xmonad.enableContribAndExtras = true;
      default = "xmonad";
    };
  };

  services.redshift = {
    enable = true;
    provider = "geoclue2";
  };
}
