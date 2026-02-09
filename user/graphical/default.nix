{ lib, pkgs, ... }:

{
  imports = [
    ./mpv.nix
    ./niri
  ];

  home.packages = import ./packages.nix pkgs;

  services.gammastep.enable = true;
  services.gammastep.provider = "manual";
  services.gammastep.latitude = "51.5072";
  services.gammastep.longitude = "-0.1276";
  services.gammastep.tray = true;

  home.sessionVariables = {
    GTK_IM_MODULE = "ibus";
    QT_IM_MODULE = "ibus";
    XMODIFIERS = "@im=ibus";
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
    keyboard.bindings = [
      { key = "Back"; mods = "Control"; chars = "\\u001b\\u007f"; }
    ];
  };

  programs.ghostty.enable = true;
  programs.ghostty.settings = {
    font-size = 8;
    window-inherit-working-directory = false;
    keybind = [
      "ctrl+backspace=text:\\x1b\\x7f"
    ];
  };

  programs.firefox.enable = true;

  home.pointerCursor.x11.enable = true;
  home.pointerCursor.name = "Vanilla-DMZ";
  home.pointerCursor.package = pkgs.vanilla-dmz;
  home.pointerCursor.size = 48;

  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    # Calibre wants to be the default for everything...
    "application/epub+zip" = "calibre-ebook-viewer.desktop";
    "application/pdf" = "org.gnome.Evince.desktop";
    "application/vnd.ms-word.document.macroenabled.12" = "writer.desktop";
    "application/vnd.oasis.opendocument.text" = "writer.desktop";
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "writer.desktop";
    "application/x-extension-htm" = "firefox.desktop";
    "application/x-extension-html" = "firefox.desktop";
    "application/x-extension-shtml" = "firefox.desktop";
    "application/x-extension-xht" = "firefox.desktop";
    "application/x-extension-xhtml" = "firefox.desktop";
    "application/xhtml+xml" = "firefox.desktop";
    "application/x-mobi8-ebook" = "calibre-ebook-viewer.desktop";
    "image/vnd.djvu" = "org.gnome.Evince.desktop";
    "text/html" = "firefox.desktop";
    "text/rtf" = "writer.desktop;";
    "x-scheme-handler/chrome" = "firefox.desktop";
    "x-scheme-handler/ftp" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/msteams" = "teams.desktop";
    "x-scheme-handler/sgnl" = "signal-desktop.desktop";
  };
}
