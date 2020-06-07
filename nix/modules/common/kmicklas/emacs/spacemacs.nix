{ pkgs, ... }:

{
  home.file.".spacemacs".source = ../../../../../dotfiles/spacemacs;
  home.file.".emacs.d/spacemacs".source = ../../../../../dep/spacemacs;
  home.file.".emacs.d/spacemacs.el".text = ''
    (setq spacemacs-start-directory "~/.emacs.d/spacemacs/")
    (load-file (concat spacemacs-start-directory "init.el"))
  '';

  # Must use system emacs because home-manager one has custom packages.
  programs.zsh.shellAliases.spacemacs = "${pkgs.emacs}/bin/emacs -q -l ~/.emacs.d/spacemacs.el";
}
