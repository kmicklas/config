{ pkgs, ... }:

{
  imports = [
    ../../user/base

    ../../user/emacs
    ../../user/git.nix
  ];

  programs.git.extraConfig = {
    "url \"https://github.com\"".insteadOf = "ssh://git@github.com";
  };

  programs.emacs.init = {
    usePackage = {
      groovy-mode = {
        enable = true;
      };

      lsp-pyright = {
        enable = true;
        after = [ "lsp-mode" ];
      };
    };
  };

  home.packages = with pkgs; [
    dive
    go_1_18
    gopls
    nix
    pyright
  ];
}
