{ config, pkgs, ... }:

{
  imports = [
    ../common
    ../graphical
    ../libinput.nix
    ../media-keys.nix
    ../efi-boot.nix
  ];

  environment.systemPackages = with pkgs; [
    fbterm # compensate for UHD
  ];
}
