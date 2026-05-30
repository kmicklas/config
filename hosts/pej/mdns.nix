{ lib, ... }:

{
  networking.firewall.allowedUDPPorts = [ 5353 ];

  services.resolved.enable = true;
  services.resolved.settings.Resolve = {
    LLMNR = false;
    MulticastDNS = lib.mkDefault "resolve";
  };
}
