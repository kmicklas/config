{ config, pkgs, ... }:

let
  source = import ../../../nix/sources.nix { };
  pkgs-unstable = import source.nixpkgs-unstable { };
  wallpaper = source.mud;

in
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

  services.swayidle.enable = true;
  services.swayidle.events = [
    {
      event = "before-sleep";
      command = "${config.programs.swaylock.package}/bin/swaylock --daemonize";
    }
  ];
  services.swayidle.timeouts = [
    {
      timeout = 60 * 60;
      command = "${config.programs.swaylock.package}/bin/swaylock --daemonize";
    }
    {
      timeout = 60 * 60 * 2;
      command = "niri msg action power-off-monitors";
    }
  ];

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
  programs.waybar.style = ''
    @import "${config.programs.waybar.package}/etc/xdg/waybar/style.css";
    window#waybar {
      background-color: rgba(43, 48, 59, 1.0);
    }
  '';

  xdg.configFile."niri/config.kdl".source = ./config.kdl;
  xdg.configFile."niri/wallpaper".source = wallpaper;

  home.packages = [
    pkgs.swaybg
    pkgs.wdisplays
    pkgs.wl-clipboard-rs
    pkgs.wlr-randr
    pkgs.xwayland-satellite
    pkgs-unstable.noctalia-shell
    pkgs.quickshell
  ];
}
