{ pkgs, ... }:

let
  nixpkgsConfig = ../../../../dotfiles/config/nixpkgs/config.nix;
in

{
  nixpkgs.config = import nixpkgsConfig;
  xdg.configFile."nixpkgs/config.nix".source = nixpkgsConfig;

  home.packages = with pkgs; [
    cachix
    (haskell.lib.doJailbreak (haskellPackages.nix-thunk.override (_: {
      github = haskellPackages.github.overrideAttrs (_: {
        patches = [];
      });
    })))
    nix-tree
  ];
}
