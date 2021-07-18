{ ... }:

{
  programs.ssh.enable = true;
  programs.ssh.extraConfig = ''
    Host kjuk
      HostName 192.168.1.231
      User kmicklas
  '';
}
