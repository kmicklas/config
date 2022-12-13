{ pkgs, ... }:

{
  imports = [
    ../../user/base

    ../../user/emacs
    ../../user/git.nix
  ];

  home.packages = with pkgs; [
    dive
    go_1_18
    gopls
    nix
    pyright
  ];
}
