{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/sda2";
    }
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/boot" =
    { device = "/dev/sda1";
      fsType = "vfat";
    };

  fileSystems."/" =
    { device = "zroot/nixos";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "zroot/nixos/home";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "zroot/nixos/nix";
      fsType = "zfs";
    };

  swapDevices = [ ];

  nix.maxJobs = lib.mkDefault 16;
}
