{ pkgs, ... }:

{
  imports = [
    ./emacs.nix
    ./git.nix
    ./haskell.nix
    ./home-manager.nix
    ./nixpkgs.nix
  ];
}
