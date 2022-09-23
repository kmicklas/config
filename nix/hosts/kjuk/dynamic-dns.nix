{ ... }:

{
  services.ddclient.enable = true;
  services.ddclient.server = "api.dynu.com";
  services.ddclient.username = "kmicklas";
  services.ddclient.passwordFile = "/root/dynu-password";
  services.ddclient.domains = [ "home.kmicklas.com" ];
}
