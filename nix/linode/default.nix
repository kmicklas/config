{ config, pkgs, ... }:

{
  imports = [
    ../common
    <nixpkgs/nixos/modules/profiles/qemu-guest.nix>
  ];

  fileSystems."/" = {
    device = "/dev/sda";
    fsType = "ext4";
  };

  swapDevices = [ { device = "/dev/sdb"; } ];

  boot = {
    initrd.availableKernelModules = [
      "9p"
      "9pnet_virtio"
      "ata_piix"
      "virtio_blk"
      "virtio_net"
      "virtio_pci"
      "virtio_scsi"
    ];

    kernelParams = [ "console=ttyS0" ];

    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/sda";
      extraConfig = ''
        serial; terminal_input serial; terminal_ouput serial
      '';
      forceInstall = true;
    };
  };

  networking.hostName = "moura";
}
