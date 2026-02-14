{ config, ... }:

{
  programs.emacs.enable = true;
  programs.emacs.extraPackages = epkgs: [
    epkgs.ample-theme
    epkgs.consult
    epkgs.doom-modeline
    epkgs.doom-themes
    epkgs.format-all
    epkgs.general
    epkgs.git-gutter
    epkgs.go-mode
    epkgs.lsp-mode
    epkgs.lsp-pyright
    epkgs.lsp-ui
    epkgs.magit
    epkgs.nix-ts-mode
    epkgs.orderless
    epkgs.python
    epkgs.rust-mode
    epkgs.treesit-auto
    epkgs.treesit-grammars.with-all-grammars
    epkgs.uuidgen
    epkgs.vertico
  ];

  # programs.emacs.extraConfig = builtins.readFile ./init.el;
  xdg.configFile."emacs/init.el".source = config.lib.file.mkOutOfStoreSymlink (
    builtins.toPath ./init.el
  );
}
