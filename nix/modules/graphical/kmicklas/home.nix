{ pkgs, ... }:

{
  imports = [
    ./anki.nix
    ./ao.nix
    ./mpv.nix
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
    # TODO: Patch xmonad-contrib to fix
    # https://github.com/xmonad/xmonad-contrib/issues/280
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
    shortcuts = {
      close_all = "mod4+g";
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

  programs.termite = {
    enable = true;
    scrollbackLines = 100000;
    font = "Monospace 8";
  };

  programs.firefox.enable = true;

  xsession.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 48;
  };
}
