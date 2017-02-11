{ config, pkgs, ... }:

{
  hardware.pulseaudio.enable = true;

  environment.systemPackages = (import ./packages.nix) pkgs;

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      ubuntu_font_family
      unifont
      google-fonts
      font-droid
      source-han-sans-japanese
      source-han-sans-korean
      source-han-sans-simplified-chinese
      source-han-sans-traditional-chinese
    ];
  };

  nixpkgs.config.firefox.enableAdobeFlash = true;

  services.printing.enable = true;

  services.xserver.enable = true;
  services.xserver.layout = "us";

  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  services.xserver.windowManager.default = "xmonad";
  services.xserver.desktopManager.xterm.enable = false;
}
