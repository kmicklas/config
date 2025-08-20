{ pkgs, ... }:

{
  # Niri enabled in system config for now.

  xdg.portal.enable = true;
  xdg.portal.config.common.default = "*";
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
  ];

  programs.fuzzel.enable = true;

  programs.swaylock.enable = true;
  programs.swaylock.settings = {
    color = "000000";
  };

  programs.waybar.enable = true;
  programs.waybar.settings.main = {
    modules-left = [
        "niri/workspaces"
    ];
    modules-center = [
        "niri/window"
    ];
    # TODO: add back icons/settings from default config
    modules-right = [
        "pulseaudio"
        "network" # TODO: get back wifi network name
        "cpu"
        "memory"
        "temperature"
        "battery"
        "clock"
        "tray"
    ];
  };

  xdg.configFile."niri/config.kdl".source = ./config.kdl;

  home.packages = [
    pkgs.wdisplays
    pkgs.wl-clipboard-rs
    pkgs.wlr-randr
    pkgs.xwayland-satellite
  ];
}
