{ inputs, pkgs, ... }:

{
  ## DISK CONFIGURATION

  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.dell-xps-13-9360

    ../../system/common
    ../../system/efi-boot.nix
  ];

  boot.supportedFilesystems = [ "ntfs" ];

  ## NETWORK

  networking.networkmanager.enable = true;

  ## LOCALIZATION

   i18n = {
     consoleFont = "Lat2-Terminus16";
     consoleKeyMap = "us";
     defaultLocale = "en_US.UTF-8";
     inputMethod.enabled = "ibus";
     inputMethod.ibus.engines = with pkgs.ibus-engines; [ anthy ];
   };

  ## PACKAGES & ENV
    
  # Steam not supported as a user package...
  programs.steam = {
     enable = true;
     remotePlay.openFirewall = true;
     dedicatedServer.openFirewall = true;
  };

  services.flatpak.enable = true;
  xdg.portal.enable = true;  

  nix.nixPath = [ ("nixos-config=" + builtins.toPath ./default.nix) ];

  ## SERVICES
  services.physlock.enable = true;
  services.physlock.allowAnyUser = true;

  # List services that you want to enable:

  services.locate.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.  
  hardware.bluetooth.enable = true;

  # This is for steam
  hardware.opengl = {
    enable = true;
#    driSupport = true;
#    driSupport32bit = true;
  };
  
  ## X11 SERVER

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      ubuntu-sans
      unifont
      google-fonts
      noto-fonts
      source-han-sans
    ];
  };

  # Enable touchpad support.
  services.xserver.libinput.enable = true;
  services.xserver.libinput.tapping = true;
  services.xserver.libinput.disableWhileTyping = true;
  services.xserver.wacom.enable = true;


  # Enable XMonad.
  services.xserver.desktopManager.xterm.enable = true;
  services.xserver.displayManager.sddm.enable = true;

  ## USERS

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.extraUsers.maddy = {
     isNormalUser = true;
     isSystemUser = false;
     uid = 1000;
     createHome = true;
     home = "/home/maddy";
     extraGroups = [
       "maddy" "wheel" "networkmanager"
     ];
   };


  system.stateVersion = "18.09";
}
