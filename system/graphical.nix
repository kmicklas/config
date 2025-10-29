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
    noto-fonts-emoji
    source-han-sans-japanese
    source-han-sans-korean
    source-han-sans-simplified-chinese
    source-han-sans-traditional-chinese
    ubuntu_font_family
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

  # TODO: switch to pipewire?
  services.pipewire.enable = false;
  services.pulseaudio.enable = true;
  services.pulseaudio.package = pkgs.pulseaudioFull;
  services.pulseaudio.daemon.config.flat-volumes = "no";

  networking.networkmanager.enable = true;
  networking.dhcpcd.enable = false;

  services.printing.enable = true;

  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";
  services.xserver.enableCtrlAltBackspace = true;
  # Needed for .xsession on NixOS 20.03.
  services.xserver.desktopManager.xterm.enable = true;

  # Niri doesn't work in lightdm
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;

  services.xserver.autoRepeatDelay = 200;
  # Unlike `xset r rate`, this is milliseconds not Hz.
  services.xserver.autoRepeatInterval = builtins.floor (1000 / 50);

  programs.niri.enable = true;
  security.pam.services.swaylock = {};

  services.flatpak.enable = true;

  i18n.inputMethod.enable = true;
  i18n.inputMethod.type = "ibus";
  i18n.inputMethod.ibus.engines = with pkgs.ibus-engines; [ libpinyin ];

  services.logind.lidSwitchDocked = "suspend";
  services.logind.extraConfig = ''
    HandlePowerKey=suspend
  '';

  # Prevent user services from blocking shutdown for a long time
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=20s
  '';

  programs.adb.enable = true;

  programs.steam.enable = true;
  programs.steam.remotePlay.openFirewall = true;
  programs.steam.dedicatedServer.openFirewall = true;
}
