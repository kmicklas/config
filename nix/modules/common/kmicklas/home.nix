{ pkgs, ... }:

let
  nixpkgsConfig = ../../../../dotfiles/config/nixpkgs/config.nix;
in

{
  nixpkgs.config = import nixpkgsConfig;
  xdg.configFile."nixpkgs/config.nix".source = nixpkgsConfig;

  home.packages = (import ./packages.nix pkgs) ++ [
    # TODO: Consider using nixpkgs version once it's more stable/up-to-date.
    (import ../../../../dep/home-manager { inherit pkgs; }).home-manager
    (import ../../../../dep/obelisk {}).command
  ];

  programs.git.enable = true;
  programs.git.package = pkgs.gitAndTools.gitFull;
  programs.git.userName = "Ken Micklas";
  programs.git.userEmail = "kmicklas@gmail.com";
  programs.git.extraConfig = {
    mergeTool.keepBackup = false;
    push.default = "simple";
    # TODO: Auto-generate these.
    "url \"ssh://git@github.com\"".insteadOf = "https://github.com";
    "url \"ssh://git@gitlab.com\"".insteadOf = "https://gitlab.com";
    "url \"ssh://git@bitbucket.com\"".insteadOf = "https://bitbucket.com";
  };
  programs.git.ignores = [
    "*~"
    "cabal.project.local"
    "dist-newstyle"
  ];

  home.file.".ghci".source = ../../../../dotfiles/ghci;

  programs.emacs.enable = true;
  services.emacs.enable = true;
  home.sessionVariables.EDITOR = "emacseditor --create-frame --tty";
  home.sessionVariables.VISUAL = "emacseditor --create-frame";
}
