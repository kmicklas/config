{ pkgs, lib, ... }:

{
  imports = [
    ../../user/base

    ../../user/git.nix
    ../../user/rust.nix
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

  home.packages = with pkgs; [
    dive
    go_1_20
    gopls
    nix
  ];
}
