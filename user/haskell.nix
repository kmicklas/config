{ pkgs, ... }:

{
  home.packages = with pkgs; [
    clang # 'ar' is needed by cabal.

    ghc
    cabal-install

    ghcid
    haskell-language-server

    haskellPackages.cabal-fmt
    stylish-haskell
  ];

  programs.git.ignores = [
    "cabal.project.local"
    "dist-newstyle"
  ];

  home.file.".ghci".source = ../dotfiles/ghci;
}
