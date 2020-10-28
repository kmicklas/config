{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (self: _: {
      obelisk = (import ../../../../dep/obelisk {}).command;

      cabal-fmt = (self.haskellPackages.extend (_: super: {
        Cabal = super.Cabal_3_0_0_0;
      })).cabal-fmt;

      stylish-haskell = (self.haskellPackages.extend (_: super: {
        HsYAML = super.HsYAML_0_2_1_0;
        haskell-src-exts = super.haskell-src-exts_1_23_0;
      })).stylish-haskell;
    })
  ];
  home.packages = with pkgs; [
    binutils # 'ar' is needed by cabal.

    ghc
    cabal-install

    obelisk

    ghcid
    haskellPackages.ghcide

    cabal-fmt
    stylish-haskell
  ];

  programs.git.ignores = [
    "cabal.project.local"
    "dist-newstyle"
  ];

  home.file.".ghci".source = ../../../../dotfiles/ghci;
}
