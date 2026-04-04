{ inputs, ... }:

{
  ## DISK CONFIGURATION

  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.dell-xps-13-9360

    ../../system/common
    ../../system/efi-boot.nix
    ../../system/graphical.nix
  ];

  boot.supportedFilesystems = [ "ntfs" ];

  ## PACKAGES & ENV

  nix.nixPath = [ ("nixos-config=" + builtins.toPath ./default.nix) ];

  ## SERVICES

  services.locate.enable = true;
  
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
