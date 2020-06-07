{ pkgs, ... }:

{
  home.packages = [
    (import ../../../../dep/obelisk {}).command
  ] ++ (with pkgs; [
    binutils # 'ar' is needed by cabal.

    ghc
    cabal-install

    haskellPackages.ghcid
    (haskellPackages.extend (self: _: {
      ghcide = pkgs.haskell.lib.dontCheck (self.callHackageDirect {
        pkg = "ghcide";
        ver = "0.2.0";
        sha256 = "199l4qzrghhz6wbfkgqdl4gll4wvgpr190kinzhv88idnn9pxm96";
      } {});
      ghc-check = self.callHackageDirect {
        pkg = "ghc-check";
        ver = "0.3.0.1";
        sha256 = "1dj909m09m24315x51vxvcl28936ahsw4mavbc53danif3wy09ns";
      } {};
      haddock-library = self.haddock-library_1_8_0;
      haskell-lsp = self.callHackageDirect {
        pkg = "haskell-lsp";
        ver = "0.22.0.0";
        sha256 = "1q3w46qcvzraxgmw75s7bl0qvb2fvff242r5vfx95sqska566b4m";
      } {};
      haskell-lsp-types = self.callHackageDirect {
        pkg = "haskell-lsp-types";
        ver = "0.22.0.0";
        sha256 = "1apjclphi2v6ggrdnbc0azxbb1gkfj3x1vkwpc8qd6lsrbyaf0n8";
      } {};
      hie-bios = pkgs.haskell.lib.dontCheck (self.callHackageDirect {
        pkg = "hie-bios";
        ver = "0.5.0";
        sha256 = "116nmpva5jmlgc2dgy8cm5wv6cinhzmga1l0432p305074w720r2";
      } {});
      lsp-test = pkgs.haskell.lib.dontCheck (self.callHackageDirect {
        pkg = "lsp-test";
        ver = "0.11.0.1";
        sha256 = "085mx5kfxls6y8kyrx0v1xiwrrcazx10ab5j4l5whs4ll44rl1bh";
      } {});
      parser-combinators = self.parser-combinators_1_2_1;
      regex-tdfa = self.regex-tdfa_1_3_1_0;
    })).ghcide

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
