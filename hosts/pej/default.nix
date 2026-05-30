{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../system/common
    ../../system/efi-boot.nix
    ../../system/graphical.nix
    ../../system/kmicklas.nix
    ../../system/libinput.nix
  ];

  # Attempt to work around unsuspend screen issues:
  # https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux/+/d5bdf88d1f9d1e4808177f03d89de3d0ba6c6e84
  # TODO(26.11): remove
  boot.kernelPackages = pkgs.linuxPackages_7_0;

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/b05d8c49-05f8-4428-bfa5-8243b8a4792c";
      allowDiscards = true;
    };
  };

  # Keep these in sync with hardware-configuration.nix
  fileSystems."/".options = [ "noatime" ];
  fileSystems."/nix".options = [ "noatime" ];
  fileSystems."/home".options = [ "noatime" ];
  fileSystems."/boot".options = [ "noatime" ];

  # TODO(26.11): remove this when it becomes default
  boot.zfs.forceImportRoot = false;

  networking.hostId = "3d3f0c83";

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;

  nix.nixPath = [ ("nixos-config=" + builtins.toPath ./default.nix) ];

  system.stateVersion = "23.05";
}
