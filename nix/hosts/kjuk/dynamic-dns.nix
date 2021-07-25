{ ... }:

{
  services.ddclient.enable = true;
  services.ddclient.server = "api.dynu.com";
  services.ddclient.username = "kmicklas";
  services.ddclient.password = builtins.readFile /root/dynu-password;
  services.ddclient.domains = [ "home.kmicklas.com" ];
}
