{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.aider-chat
  ];

  programs.git.ignores = [
    ".aider.*"
  ];

  home.file.".aider.conf.yml".text = ''
    attribute-author: false
    attribute-committer: false

    gitignore: false

    env-file: ${config.xdg.configHome}/aider/env
  '';
}
