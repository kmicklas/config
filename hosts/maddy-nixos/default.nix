{ inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.dell-xps-13-9360

    ../../system/common
    ../../system/efi-boot.nix
    ../../system/graphical.nix
  ];

  users.extraUsers.maddy = let
    homedir = "/home/maddy";
  in {
    isNormalUser = true;
    isSystemUser = false;
    uid = 1000;
    createHome = true;
    home = homedir;
    shell = homedir + "/.nix-profile/bin/zsh";
    useDefaultShell = true;
    extraGroups = [ "maddy" "wheel" "networkmanager" ];
  };

  nix.nixPath = [ ("nixos-config=" + builtins.toPath ./default.nix) ];

  system.stateVersion = "18.09";
}
