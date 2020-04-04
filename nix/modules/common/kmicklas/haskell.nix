{ pkgs, ... }:

{
  home.packages = [
    (import ../../../../dep/obelisk {}).command
  ] ++ (with pkgs; [
    stack
    cabal-install
    haskellPackages.ghcid
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
