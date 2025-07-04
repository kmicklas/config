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
  programs.waybar.enable = true;

  xdg.configFile."niri/config.kdl".source = ./config.kdl;
}
