{ pkgs, ... }:

{
  imports = [
    ../../user/base

    ../../user/emacs
    ../../user/git.nix
  ];

  programs.git.extraConfig = {
    "url \"https://github.com\"".insteadOf = "ssh://git@github.com";
  };

  home.packages = with pkgs; [
    dive
    go_1_18
    gopls
    nix
    pyright
  ];
}
