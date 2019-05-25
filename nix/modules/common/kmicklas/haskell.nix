{ pkgs, ... }:

{
  home.packages = [
    (import ../../../../dep/obelisk {}).command
  ] ++ (with pkgs; [
    stack
    cabal-install
    haskellPackages.ghcid
    haskellPackages.stylish-haskell
  ]);

  programs.git.ignores = [
    "cabal.project.local"
    "dist-newstyle"
  ];

  home.file.".ghci".source = ../../../../dotfiles/ghci;
}
