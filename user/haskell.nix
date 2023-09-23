{ pkgs, ... }:

{
  home.packages = [
    (import ../dep/obelisk {}).command
  ] ++ (with pkgs; [
    binutils # 'ar' is needed by cabal.

    ghc
    cabal-install

    ghcid
    haskell-language-server

    haskellPackages.cabal-fmt
    stylish-haskell
  ]);

  programs.git.ignores = [
    "cabal.project.local"
    "dist-newstyle"
  ];

  home.file.".ghci".source = ../dotfiles/ghci;

  programs.emacs.init = {
    usePackage = {
      lsp-haskell = {
        after = [ "lsp-mode" ];
        enable = true;
      };
    };
  };
}
