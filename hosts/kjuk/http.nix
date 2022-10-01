{ ... }:

{
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.nginx.enable = true;
  services.nginx.recommendedProxySettings = true;
  services.nginx.virtualHosts."feeds.home.kmicklas.com" = {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:" + toString 8080;
      proxyWebsockets = true;
      extraConfig = ''
        access_log off;
      '';
    };
  };
}
