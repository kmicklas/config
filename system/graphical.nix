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
    noto-fonts-cjk
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

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  hardware.pulseaudio.daemon.config.flat-volumes = "no";

  networking.networkmanager.enable = true;
  networking.dhcpcd.enable = false;

  services.printing.enable = true;

  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";
  services.xserver.enableCtrlAltBackspace = true;
  # Needed for .xsession on NixOS 20.03.
  services.xserver.desktopManager.xterm.enable = true;

  services.xserver.autoRepeatDelay = 200;
  services.xserver.autoRepeatInterval = 50;
  powerManagement.resumeCommands = ''
    sleep 10
    DISPLAY=:0 XAUTHORITY=/home/kmicklas/.Xauthority ${pkgs.xorg.xset}/bin/xset r rate 200 50
    # Just in case...
    sleep 60
    DISPLAY=:0 XAUTHORITY=/home/kmicklas/.Xauthority ${pkgs.xorg.xset}/bin/xset r rate 200 50
  '';

  i18n.inputMethod.enabled = "ibus";
  i18n.inputMethod.ibus.engines = with pkgs.ibus-engines; [ libpinyin ];

  services.logind.lidSwitchDocked = "suspend";
  services.logind.extraConfig = ''
    HandlePowerKey=suspend
  '';

  # Prevent user services from blocking shutdown for a long time
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=20s
  '';

  services.physlock.enable = true;
  services.physlock.allowAnyUser = true;

  programs.adb.enable = true;
}
