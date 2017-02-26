{ config, pkgs, ... }:

{
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = true;

  environment.systemPackages = (import ./packages.nix) pkgs;
  fonts = (import ./fonts.nix) pkgs;

  nixpkgs.config.firefox.enableAdobeFlash = true;

  services.printing.enable = true;

  services.xserver.enable = true;
  services.xserver.layout = "us";

  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  services.xserver.windowManager.default = "xmonad";
  services.xserver.desktopManager.xterm.enable = false;
}
