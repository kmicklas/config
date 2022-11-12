{ pkgs, ... }:

{
  imports = [
    ../../user/base
    ../../user/graphical

    ../../user/emacs
    ../../user/git.nix
    ../../user/go.nix
    ../../user/haskell.nix
    ../../user/ssh.nix
    ../../user/rust.nix
  ];

  programs.git.userEmail = "git@kmicklas.com";

  home.packages = with pkgs; [
    wally-cli
  ];
}