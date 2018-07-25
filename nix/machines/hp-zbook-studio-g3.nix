{ config, pkgs, ... }:

{
  imports = [
    ../modules/common
    ../modules/graphical
    ../modules/libinput.nix
    ../modules/efi-boot.nix
  ];

  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.dpi = 160;
}
