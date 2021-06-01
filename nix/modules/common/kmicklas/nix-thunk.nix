{ pkgs, ... }:

{
  home.packages = [
    pkgs.haskellPackages.nix-thunk
  ];
}
