{ config, pkgs, ... }:

let
  prefix = "${config.xdg.dataHome}/npm";
in
{
  home.packages = [
    pkgs.nodejs_latest
  ];
  # Some decade the normies will learn how to XDG...
  home.file.".npmrc".text = ''
    prefix = ${prefix}
  '';
  home.sessionPath = [ "${prefix}/bin" ];
}
