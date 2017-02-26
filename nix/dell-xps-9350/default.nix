{ config, pkgs, ... }:

{
  imports = [
    ../common
    ../graphical
    ../libinput.nix
    ../media-keys.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.systemPackages = with pkgs; [
    fbterm # compensate for UHD
  ];
}
