{ config, pkgs, ... }:

{
  imports = [
    ../modules/common
    ../modules/graphical
    ../modules/libinput.nix
    ../modules/media-keys.nix
    ../modules/efi-boot.nix
  ];

  environment.systemPackages = with pkgs; [
    fbterm # compensate for UHD
  ];
}
