{ ... }:

{
  programs.ssh.enable = true;
  programs.ssh.extraConfig = ''
    Host kjuk
      HostName ${import ../../../hosts/kjuk/ip.nix}
      User kmicklas
  '';
}
