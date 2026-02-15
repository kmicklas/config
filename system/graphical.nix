{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gparted
  ];

  fonts.fontDir.enable = true;
  fonts.enableGhostscriptFonts = true;
  fonts.packages = with pkgs; [
    corefonts
    google-fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    source-han-sans
    ubuntu-sans
    unifont
    wqy_microhei
    wqy_zenhei
  ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };

  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;

  networking.networkmanager.enable = true;
  networking.dhcpcd.enable = false;

  services.printing.enable = true;

  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";
  services.xserver.enableCtrlAltBackspace = true;
  # Needed for .xsession on NixOS 20.03.
  services.xserver.desktopManager.xterm.enable = true;

  # Niri doesn't work in lightdm
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  services.xserver.autoRepeatDelay = 200;
  # Unlike `xset r rate`, this is milliseconds not Hz.
  services.xserver.autoRepeatInterval = builtins.floor (1000 / 50);

  programs.niri.enable = true;

  services.physlock.enable = true;
  services.physlock.allowAnyUser = true;
  services.physlock.disableSysRq = false;

  services.flatpak.enable = true;

  i18n.inputMethod.enable = true;
  i18n.inputMethod.type = "ibus";
  i18n.inputMethod.ibus.engines = with pkgs.ibus-engines; [ libpinyin ];

  services.logind.settings.Login = {
    HandleLidSwitchDocked = "suspend";
    HandlePowerKey = "suspend";
  };

  # Prevent user services from blocking shutdown for a long time
  systemd.settings.Manager = {
    DefaultTimeoutStopSec = "20s";
  };

  programs.adb.enable = true;

  programs.steam.enable = true;
  programs.steam.remotePlay.openFirewall = true;
  programs.steam.dedicatedServer.openFirewall = true;
}
