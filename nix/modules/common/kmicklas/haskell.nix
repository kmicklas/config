{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (self: _: {
      obelisk = (import ../../../../dep/obelisk {}).command;
    })
  ];
  home.packages = with pkgs; [
    binutils # 'ar' is needed by cabal.

    ghc
    cabal-install

    obelisk

    ghcid
    haskellPackages.ghcide

    haskellPackages.cabal-fmt
    stylish-haskell
  ];

  programs.git.ignores = [
    "cabal.project.local"
    "dist-newstyle"
  ];

  home.file.".ghci".source = ../../../../dotfiles/ghci;
}
