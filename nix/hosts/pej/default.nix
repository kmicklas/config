{ ... }:

{
  imports = [
    ../../modules/common
    ../../modules/graphical
    ../../modules/libinput.nix
    ../../modules/efi-boot.nix
    ../../modules/gitlab-runner
    ./hardware-configuration.nix
  ];

  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.cpu.amd.updateMicrocode = true;

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/fa0fcd31-bd41-41a2-a1ff-b122e8bc67c0";
      allowDiscards = true;
    };
  };

  networking.hostName = "pej";
  networking.hostId = "3d3f0c83";

  nix.nixPath = [ ("nixos-config=" + builtins.toPath ./default.nix) ];
}
