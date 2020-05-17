{ pkgs, ... }:

{
  home.packages = [
    (import ../../../../dep/obelisk {}).command
  ] ++ (with pkgs; [
    binutils # 'ar' is needed by cabal.

    ghc
    cabal-install
    stack

    haskellPackages.ghcid
    haskellPackages.ghcide

    (haskellPackages.extend (_: super: {
      Cabal = super.Cabal_3_0_0_0;
    })).cabal-fmt
    (haskellPackages.extend (_: super: {
      HsYAML = super.HsYAML_0_2_1_0;
      haskell-src-exts = super.haskell-src-exts_1_23_0;
    })).stylish-haskell
  ]);

  programs.git.ignores = [
    "cabal.project.local"
    "dist-newstyle"
  ];

  home.file.".ghci".source = ../../../../dotfiles/ghci;
}
