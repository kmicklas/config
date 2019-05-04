{ ... }:

{
  services.xscreensaver.enable = true;
  services.xscreensaver.settings.mode = "blank";

  xresources.properties = {
    "Xft.dpi" = 192;
    "Xcursor.size" = 48;
  };
}
