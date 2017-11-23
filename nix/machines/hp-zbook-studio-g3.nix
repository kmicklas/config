{ config, pkgs, ... }:

{
  imports = [
    ../modules/common
    ../modules/graphical
    ../modules/libinput.nix
    ../modules/efi-boot.nix
  ];
}
