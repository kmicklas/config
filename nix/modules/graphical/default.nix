{ config, pkgs, ... }:

{
  hardware = {
    bluetooth.enable = true;
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      daemon.config.flat-volumes = "no";
    };
  };

  environment.systemPackages = (import ./packages.nix) pkgs;
  fonts = (import ./fonts.nix) pkgs;

  networking.networkmanager.enable = true;

  services.printing.enable = true;

  programs.adb.enable = true;

  services.xserver = {
    enable = true;
    layout = "us";
    enableCtrlAltBackspace = true;

    displayManager = {
      sessionCommands = ''
        xscreensaver -no-splash &
        albert &
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

  services.compton = {
    enable = true;
    fade = true;
    fadeDelta = 5;
    extraOptions = "inactive-dim = 0.05;";
  };
}
