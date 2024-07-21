{ ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../system/common
    ../../system/efi-boot.nix
    ../../system/graphical.nix
    ../../system/kmicklas.nix
    ../../system/libinput.nix
    ../../system/media-keys.nix
  ];

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/03f795b1-3449-44ed-992f-133c0691241d";
      allowDiscards = true;
    };
  };

  networking.hostName = "meitan";
  networking.hostId = "96a6ca18";

  nix.nixPath = [ ("nixos-config=" + builtins.toPath ./default.nix) ];
}
