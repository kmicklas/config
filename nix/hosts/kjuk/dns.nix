{ ... }:

{
  networking.firewall.allowedTCPPorts = [ 53 ];
  networking.firewall.allowedUDPPorts = [ 53 ];

  services.dnsmasq.enable = true;
  services.dnsmasq.extraConfig = ''
    address=/home.kmicklas.com/${import ./ip.nix}
  '';
}
