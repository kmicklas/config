{ lib, ... }:

{
  imports = [
    ../../../../profiles/kmicklas/home
  ];

  xresources.properties = {
    "Xft.dpi" = 128;
  };

  services.gammastep.provider = lib.mkForce "geoclue2";

  home.stateVersion = "23.05";
}
