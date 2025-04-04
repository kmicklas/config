{ config, ... }:

let
  source = import ../nix/sources.nix { };
  nixpkgs-unstable = import source.nixpkgs-unstable { };
in {
  home.packages = [
    nixpkgs-unstable.aider-chat
  ];

  programs.git.ignores = [
    ".aider.*"
  ];

  home.file.".aider.conf.yml".text = ''
    auto-commits: false
    attribute-author: false
    attribute-committer: false

    check-update: false

    gitignore: false

    env-file: ${config.xdg.configHome}/aider/env
  '';
}
