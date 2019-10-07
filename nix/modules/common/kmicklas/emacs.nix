{ lib, ... }:

# For reasons I dont't understand there is infinite recursion if I take pkgs as
# a parameter.
let pkgs = import <nixpkgs> {};

in {
  programs.emacs.enable = true;
  home.sessionVariables.EDITOR = "emacsclient --create-frame --tty";
  home.sessionVariables.VISUAL = "emacsclient --create-frame";

  home.file.".spacemacs".source = ../../../../dotfiles/spacemacs;
  home.file.".emacs.d/spacemacs".source = ../../../../dep/spacemacs;
  home.file.".emacs.d/init.el".text = ''
    (setq spacemacs-start-directory "~/.emacs.d/spacemacs/")
    (load-file (concat spacemacs-start-directory "init.el"))
  '';
} // lib.optionalAttrs (!pkgs.stdenv.isDarwin) {
  services.emacs.enable = true;
}
