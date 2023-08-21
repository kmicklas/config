{ pkgs, lib, ... }:

{
  imports = [
    ../../user/base

    ../../user/emacs
    ../../user/git.nix
  ] ++ lib.optionals (builtins.pathExists ../../../local-config) [
    ../../../local-config
  ];

  home.sessionVariables = {
    NIX_PATH = "$NIX_PATH\${NIX_PATH:+:}nixpkgs=${builtins.toPath ../../dep/nixpkgs}";
  };

  programs.git.extraConfig = {
    "url \"https://github.com/\"".insteadOf = [
      "git@github.com:"
      "ssh://git@github.com:"
    ];
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
    go_1_20
    gopls
    nix
    pyright
  ];
}
