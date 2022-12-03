{ ... }:

{
  imports = [
    ./home-manager.nix
    ./nixpkgs.nix
    ./zsh.nix
  ];

  home.sessionPath = [ "$HOME/.local/bin" ];

  home.homeDirectory = "/home/kmicklas";
  home.username = "kmicklas";

  home.stateVersion = "22.05";
}
