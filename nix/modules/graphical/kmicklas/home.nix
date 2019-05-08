{ pkgs, ... }:

{
  home.packages = import ./packages.nix pkgs;

  services.xscreensaver.enable = true;
  services.xscreensaver.settings.mode = "blank";

  services.redshift.enable = true;
  services.redshift.provider = "geoclue2";

  xresources.properties = {
    "Xft.dpi" = 192;
    "Xft.antialias" = true;
    "Xft.hintin" = true;
    "Xft.rgba" = "rgb";
    "Xft.hintstyle" = "hintslight";
    "Xft.lcdfilter" = "lcddefault";
    "Xcursor.size" = 48;
  };

  programs.termite = {
    enable = true;
    scrollbackLines = 100000;
    font = "Monospace 8";
  };

  xsession.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
  };
}
