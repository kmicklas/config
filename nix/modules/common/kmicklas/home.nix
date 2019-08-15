{ lib, ... }:

{
  imports = [
    ./emacs.nix
    ./git.nix
    ./haskell.nix
    ./home-manager.nix
    ./nixpkgs.nix
    ./pass.nix
    ./zsh.nix
  ] ++ lib.optionals (builtins.pathExists ../../../../private/nix/home/common) [
    ../../../../private/nix/home/common
  ];
}
