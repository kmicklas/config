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
    tree
  ];

  home.homeDirectory = "/home/kmicklas";
  home.username = "kmicklas";

  home.stateVersion = "22.05";
}
