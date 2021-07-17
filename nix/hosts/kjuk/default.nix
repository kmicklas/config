{ config, lib, pkgs, ... }:

{
  imports = [
    ../../modules/common
    # TODO: Make this a thunk or submodule.
    "${fetchTarball "https://github.com/NixOS/nixos-hardware/archive/41775780a0b6b32b3d32dcc32bb9bc6df809062d.tar.gz"}/raspberry-pi/4"
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  swapDevices = [ ];

  networking.hostName = "kjuk";
  nix.nixPath = [ ("nixos-config=" + builtins.toPath ./default.nix) ];
}
