# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  ## DISK CONFIGURATION

  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ./nixos-hardware/dell/xps/13-9360
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  ## NETWORK

  networking.hostName = "maddy-nixos"; # Define your hostname.
  networking.networkmanager.enable = true;


  ## LOCALIZATION

   i18n = {
     consoleFont = "Lat2-Terminus16";
     consoleKeyMap = "us";
     defaultLocale = "en_US.UTF-8";
     inputMethod.enabled = "ibus";
     inputMethod.ibus.engines = with pkgs.ibus-engines; [ anthy ];
   };

  time.timeZone = "America/New_York";


  ## PACKAGES & ENV
  programs.nix-ld.enable = true;
    
  # Steam not supported as a user package...
  programs.steam = {
     enable = true;
     remotePlay.openFirewall = true;
     dedicatedServer.openFirewall = true;
  };

  services.flatpak.enable = true;
  xdg.portal.enable = true;  

  nixpkgs.config = import ./nix-config.nix;

  nix.nixPath = let nixpkgs = builtins.toPath ./nixpkgs; in [
    ("nixos=" + nixpkgs)
    ("nixpkgs=" + nixpkgs)
    ("nixos-config=" + builtins.toPath ./configuration.nix)
  ];

  nix.binaryCaches = [ "https://nixcache.reflex-frp.org" ];
  nix.binaryCachePublicKeys = [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];

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
      ubuntu_font_family
      unifont
      google-fonts
      noto-fonts
      source-han-sans-japanese
      source-han-sans-korean
      source-han-sans-simplified-chinese
      source-han-sans-traditional-chinese
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


  ## NIXOS

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?

}
