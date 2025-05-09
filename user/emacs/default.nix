{ config, pkgs, ... }:

{
  programs.emacs.enable = true;
  programs.emacs.extraPackages = epkgs: [
    epkgs.treesit-grammars.with-all-grammars
    epkgs.vterm
  ];

  home.packages = [
    pkgs.fd
    pkgs.ripgrep
  ];

  xdg.configFile."emacs".source = config.lib.file.mkOutOfStoreSymlink (builtins.toPath ../../dep/doomemacs);
  xdg.configFile."doom".source = config.lib.file.mkOutOfStoreSymlink (builtins.toPath ../../doom);

  home.sessionPath = [
    "$HOME/.config/emacs/bin"
  ];
}
