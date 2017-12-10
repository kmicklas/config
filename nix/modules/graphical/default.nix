{ config, pkgs, ... }:

{
  imports = [
    ./kde.nix
  ];

  hardware = {
    bluetooth.enable = true;
    pulseaudio.enable = true;
  };

  environment.systemPackages = (import ./packages.nix) pkgs;
  fonts = (import ./fonts.nix) pkgs;

  networking.networkmanager.enable = true;

  services.printing.enable = true;

  services.xserver = {
    enable = true;
    layout = "us";

    windowManager = {
      xmonad.enable = true;
      xmonad.enableContribAndExtras = true;
      default = "xmonad";
    };
  };
}