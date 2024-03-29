{ ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../system/common
    ../../system/efi-boot.nix
    ../../system/graphical.nix
    ../../system/kmicklas.nix
    ../../system/libinput.nix
  ];

  services.xserver.videoDrivers = [ "amdgpu" ];

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/fa0fcd31-bd41-41a2-a1ff-b122e8bc67c0";
      allowDiscards = true;
    };
  };

  networking.hostName = "pej";
  networking.hostId = "3d3f0c83";

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  nix.nixPath = [ ("nixos-config=" + builtins.toPath ./default.nix) ];
}
