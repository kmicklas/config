{ lib, pkgs, ... }:

let
  wallpaper = builtins.fetchurl {
    url = "https://www.dropbox.com/s/2669wx4az2jt62t/Mud.jpg";
    sha256 = "0xb1q07719zwxcldx0fqy6c50sgkajrcv9h01yd765p9ldhi7a9b";
  };

in {
  imports = [
    ./anki.nix
    ./ao.nix
    ./mpv.nix
    ./river.nix
  ];

  home.packages = import ./packages.nix pkgs;

  services.xscreensaver.enable = true;
  services.xscreensaver.settings.mode = "blank";

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
}
