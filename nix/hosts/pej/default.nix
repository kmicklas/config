{ ... }:

{
  imports = [
    ../../modules/common
    ../../modules/graphical
    ../../modules/libinput.nix
    ../../modules/efi-boot.nix
    ./hardware-configuration.nix
  ];

  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.cpu.amd.updateMicrocode = true;

  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/disk/by-uuid/fa0fcd31-bd41-41a2-a1ff-b122e8bc67c0";
    }
  ];

  networking.hostName = "pej";
  networking.hostId = "3d3f0c83";

  nix.nixPath = [ ("nixos-config=" + builtins.toPath ./default.nix) ];
}
