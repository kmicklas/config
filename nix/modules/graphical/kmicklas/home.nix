{ ... }:

{
  services.xscreensaver.enable = true;
  services.xscreensaver.settings.mode = "blank";

  xresources.properties = {
    "Xft.dpi" = 192;
    "Xcursor.size" = 48;
  };

  programs.termite = {
    enable = true;
    scrollbackLines = 100000;
    font = "Monospace 8";
  };

  home.file.".icons/default/index.theme".source = ../../../../dotfiles/icons/default/index.theme;
}
