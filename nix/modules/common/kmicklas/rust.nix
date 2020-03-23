{ pkgs, ... }:

{
  home.file.".cargo/config".text = ''
    [net]
    git-fetch-with-cli = true
  '';
}
