{ config, pkgs, ... }:

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

  hardware.enableRedistributableFirmware = true;

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/7d3e45db-d4da-4f17-a725-dda0fdac9826";
      allowDiscards = true;
    };
  };

  networking.hostName = "tieta";
  networking.hostId = "af5f7ecb";

  nix.nixPath = [ ("nixos-config=" + builtins.toPath ./default.nix) ];
}
