{ ... }:

{
  networking.firewall.allowedTCPPorts = [ 80 ];

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
