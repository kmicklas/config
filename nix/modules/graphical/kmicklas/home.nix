{ pkgs, ... }:

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
  services.redshift.latitude = "40.712772";
  services.redshift.longitude = "-74.006058";

  xsession.enable = true;
  xsession.initExtra = ''
    ${pkgs.feh}/bin/feh --bg-fill ${wallpaper}
    xset r rate 250 30
    ibus-daemon &
    albert &
  '';
  xdg.configFile."albert/albert.conf".source = ../../../../dotfiles/config/albert/albert.conf;

  home.sessionVariables = {
    GTK_IM_MODULE = "ibus";
    QT_IM_MODULE = "ibus";
    XMODIFIERS = "@im=ibus";
  };

  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = ../../../../dotfiles/xmonad/xmonad.hs;
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
    "Xft.dpi" = 192;
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

  xsession.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 48;
  };
}
