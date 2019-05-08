{ config, pkgs, ... }:

{
  # TODO: Remove this once upstream.
  # To fix kernel panic due to i2c bug:
  boot.kernelPackages = pkgs.linuxPackages_5_0;

  environment.systemPackages = import ./packages.nix pkgs;
  fonts = import ./fonts.nix pkgs;

  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  hardware.pulseaudio.daemon.config.flat-volumes = "no";

  networking.networkmanager.enable = true;
  services.printing.enable = true;

  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.enableCtrlAltBackspace = true;

  services.logind.lidSwitch = "suspend";
  services.logind.lidSwitchDocked = "suspend";
  services.logind.lidSwitchExternalPower = "suspend";
  services.logind.extraConfig = ''
    HandlePowerKey=suspend
  '';

  services.physlock.enable = true;
  services.physlock.allowAnyUser = true;

  programs.adb.enable = true;
}
