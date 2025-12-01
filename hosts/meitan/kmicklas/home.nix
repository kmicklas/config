{ lib, ... }:

{
  imports = [
    ../../../profiles/home
  ];

  xresources.properties = {
    "Xft.dpi" = 128;
  };

  services.gammastep.provider = lib.mkForce "geoclue2";
}
