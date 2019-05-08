{ config, pkgs, ... }:

{
  # TODO: Remove this once upstream.
  # To fix kernel panic due to i2c bug:
  boot.kernelPackages = pkgs.linuxPackages_5_0;

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

  services.logind.lidSwitch = "suspend";
  services.logind.lidSwitchDocked = "suspend";
  services.logind.lidSwitchExternalPower = "suspend";
  services.logind.extraConfig = ''
    HandlePowerKey=suspend
  '';

  services.physlock.enable = true;
  services.physlock.allowAnyUser = true;
}
