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

    haskellPackages.cabal-fmt
    stylish-haskell
  ];

  programs.git.ignores = [
    "cabal.project.local"
    "dist-newstyle"
  ];

  home.file.".ghci".source = ../../../../dotfiles/ghci;

  programs.emacs.init = {
    usePackage = {
      lsp-haskell = {
        after = [ "lsp-mode" ];
        enable = true;
        # TODO: Get haskell-language-server from 21.05 instead of master once it's unbroken again.
        config = ''
          (setq lsp-haskell-server-path "${(import ../../../../dep/nixpkgs-master {}).haskell-language-server}/bin/haskell-language-server")
        '';
      };
    };
  };
}
