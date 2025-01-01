{ lib, pkgs, ... }:

let
  source = import ../../nix/sources.nix { };
  wallpaper = source.mud;

in {
  imports = [
    ./anki.nix
    ./mpv.nix
    ./river.nix
  ];

  home.packages = import ./packages.nix pkgs;

  services.xscreensaver.enable = true;
  services.xscreensaver.settings.mode = "blank";
  # https://github.com/nix-community/home-manager/issues/4796
  home.file.".xscreensaver".text = ''
    mode: blank
  '';

  services.redshift.enable = true;
  services.redshift.provider = "manual";
  services.redshift.latitude = "51.5072";
  services.redshift.longitude = "-0.1276";

  xsession.enable = true;
  xsession.initExtra = ''
    ${pkgs.xwallpaper}/bin/xwallpaper --daemon --zoom ${wallpaper}
    xset r rate 200 50
    ibus-daemon &
  '';

  home.sessionVariables = {
    GTK_IM_MODULE = "ibus";
    QT_IM_MODULE = "ibus";
    XMODIFIERS = "@im=ibus";
  };

  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = ../../dotfiles/xmonad/xmonad.hs;
  };

  services.dunst.enable = true;
  services.dunst.settings = {
    global = {
      geometry = "0x10+20-20";
      padding = 20;
      horizontal_padding = 20;
      corner_radius = 20;
    };
  };

  xresources.properties = {
    "Xft.dpi" = lib.mkDefault 192;
    "Xft.antialias" = true;
    "Xft.hintin" = true;
    "Xft.rgba" = "rgb";
    "Xft.hintstyle" = "hintslight";
    "Xft.lcdfilter" = "lcddefault";
  };

  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    font.size = 8;
    scrolling.history = 100000;
  };

  programs.firefox.enable = true;

  home.pointerCursor.x11.enable = true;
  home.pointerCursor.name = "Vanilla-DMZ";
  home.pointerCursor.package = pkgs.vanilla-dmz;
  home.pointerCursor.size = 48;

  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    # Calibre wants to be the default...
    "application/pdf" = "org.gnome.Evince.desktop";
    "application/x-extension-htm" = "firefox.desktop";
    "application/x-extension-html" = "firefox.desktop";
    "application/x-extension-shtml" = "firefox.desktop";
    "application/x-extension-xht" = "firefox.desktop";
    "application/x-extension-xhtml" = "firefox.desktop";
    "application/xhtml+xml" = "firefox.desktop";
    "text/html" = "firefox.desktop";
    "x-scheme-handler/chrome" = "firefox.desktop";
    "x-scheme-handler/ftp" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/msteams" = "teams.desktop";
    "x-scheme-handler/sgnl" = "signal-desktop.desktop";
  };
}
