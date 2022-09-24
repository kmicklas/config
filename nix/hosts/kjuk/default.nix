{ ... }:

{
  imports = [
    ../../modules/common
    "${import ../../../dep/nixos-hardware/thunk.nix}/raspberry-pi/4"
    ./dns.nix
    ./dynamic-dns.nix
    ./feeds.nix
    ./http.nix
    ./ssl.nix
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
  networking.networkmanager.enable = true;

  nix.nixPath = [ ("nixos-config=" + builtins.toPath ./default.nix) ];
}
