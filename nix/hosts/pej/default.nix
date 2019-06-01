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

  networking.hostName = "pej";
  networking.hostId = "3d3f0c83";

  nix.nixPath = [ ("nixos-config=" + builtins.toPath ./default.nix) ];
}
