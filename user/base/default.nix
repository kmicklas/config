{ pkgs, ... }:

{
  imports = [
    ./home-manager.nix
    ./nixpkgs.nix
    ./zsh.nix
  ];

  home.sessionPath = [
    "$HOME/.local/bin"
    (builtins.toPath ../../bin)
  ];

  home.packages = with pkgs; [
    bat
    exa
    jq
    tree
  ];

  home.homeDirectory = "/home/kmicklas";
  home.username = "kmicklas";

  home.stateVersion = "22.11";
}
