{ inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.dell-xps-13-9360

    ../../system/common
    ../../system/efi-boot.nix
    ../../system/graphical.nix
  ];

  users.extraUsers.maddy = {
    isNormalUser = true;
    isSystemUser = false;
    uid = 1000;
    createHome = true;
    home = "/home/maddy";
    extraGroups = [ "maddy" "wheel" "networkmanager" ];
  };

  nix.nixPath = [ ("nixos-config=" + builtins.toPath ./default.nix) ];

  system.stateVersion = "18.09";
}
