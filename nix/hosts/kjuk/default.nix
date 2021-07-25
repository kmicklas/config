{ config, lib, pkgs, ... }:

{
  imports = [
    ../../modules/common
    # TODO: Make this a thunk or submodule.
    "${fetchTarball "https://github.com/NixOS/nixos-hardware/archive/41775780a0b6b32b3d32dcc32bb9bc6df809062d.tar.gz"}/raspberry-pi/4"
    ./dns.nix
    ./dynamic-dns.nix
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  swapDevices = [ ];

  networking.firewall.allowedTCPPorts = [ 80 ];

  networking.hostName = "kjuk";
  nix.nixPath = [ ("nixos-config=" + builtins.toPath ./default.nix) ];

  services.miniflux.enable = true;

  services.nginx.enable = true;
  services.nginx.recommendedProxySettings = true;
  services.nginx.virtualHosts."rss.home.kmicklas.com" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:" + toString 8080;
      proxyWebsockets = true;
      extraConfig = ''
        access_log off;
      '';
    };
  };
}
