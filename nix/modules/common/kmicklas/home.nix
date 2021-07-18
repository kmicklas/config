{ lib, ... }:

{
  imports = [
    ./emacs
    ./git.nix
    ./haskell.nix
    ./rust.nix
    ./home-manager.nix
    ./nixpkgs.nix
    ./ssh.nix
    ./zsh.nix
  ] ++ lib.optionals (builtins.pathExists ../../../../private/nix/home/common) [
    ../../../../private/nix/home/common
  ];
}
