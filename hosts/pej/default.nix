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

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/fa0fcd31-bd41-41a2-a1ff-b122e8bc67c0";
      allowDiscards = true;
    };
  };

  # Keep these in sync with hardware-configuration.nix
  fileSystems."/".options = [ "noatime" ];
  fileSystems."/nix".options = [ "noatime" ];
  fileSystems."/home".options = [ "noatime" ];
  fileSystems."/boot".options = [ "noatime" ];

  networking.hostName = "pej";
  networking.hostId = "3d3f0c83";

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;

  nix.nixPath = [ ("nixos-config=" + builtins.toPath ./default.nix) ];
}
