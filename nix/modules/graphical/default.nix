{ config, pkgs, ... }:

{
  environment.systemPackages = import ./packages.nix pkgs;
  fonts = import ./fonts.nix pkgs;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  hardware.pulseaudio.extraModules = [ pkgs.pulseaudio-modules-bt ];
  hardware.pulseaudio.daemon.config.flat-volumes = "no";

  networking.networkmanager.enable = true;
  networking.dhcpcd.enable = false;

  services.printing.enable = true;

  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.enableCtrlAltBackspace = true;
  # Needed for .xsession on NixOS 20.03.
  services.xserver.desktopManager.xterm.enable = true;

  i18n.inputMethod.enabled = "ibus";
  i18n.inputMethod.ibus.engines = with pkgs.ibus-engines; [ libpinyin ];

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
