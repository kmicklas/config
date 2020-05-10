{ lib, ... }:

# For reasons I dont't understand there is infinite recursion if I take pkgs as
# a parameter.
let pkgs = import <nixpkgs> {};

in {
  imports = [
    (import ../../../../dep/rycee-nur {}).hmModules.emacs-init
  ];

  programs.emacs.enable = true;
  home.sessionVariables.EDITOR = "emacsclient --create-frame --tty";
  home.sessionVariables.VISUAL = "emacsclient --create-frame";

  home.file.".spacemacs".source = ../../../../dotfiles/spacemacs;
  home.file.".emacs.d/spacemacs".source = ../../../../dep/spacemacs;
  home.file.".emacs.d/spacemacs.el".text = ''
    (setq spacemacs-start-directory "~/.emacs.d/spacemacs/")
    (load-file (concat spacemacs-start-directory "init.el"))
  '';

  programs.emacs.init = {
    enable = true;

    usePackage = {
      haskell-mode = {
        enable = true;
      };
    };
  };
} // lib.optionalAttrs (!pkgs.stdenv.isDarwin) {
  services.emacs.enable = true;
}
