{ ... }:

{
  programs.emacs.enable = true;
  services.emacs.enable = true;
  home.sessionVariables.EDITOR = "emacsclient --create-frame --tty";
  home.sessionVariables.VISUAL = "emacsclient --create-frame";
  home.file.".spacemacs".source = ../../../../dotfiles/spacemacs;
}
