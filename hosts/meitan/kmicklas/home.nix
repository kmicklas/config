{ ... }:

{
  imports = [
    ../../../profiles/home
  ];

  xresources.properties = {
    "Xft.dpi" = 128;
  };

  services.gammastep.provider = "geoclue2";
}
