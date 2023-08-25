{ pkgs, ... }:

{
  imports = [
    ./home-manager.nix
    ./nixpkgs.nix
    ./tmux.nix
    ./zsh.nix
  ];

  home.sessionPath = [
    "$HOME/.local/bin"
    (builtins.toPath ../../bin)
  ];

  home.packages = with pkgs; [
    gex
    htop
    hyperfine
    jqp
    ncdu
    ripgrep
    tree
  ];

  programs.bat.enable = true;

  programs.exa.enable = true;
  programs.exa.enableAliases = true;

  programs.fzf.enable = true;

  programs.jq.enable = true;

  programs.lazygit.enable = true;
  programs.lazygit.settings = {
    # TODO: Get delta colors working properly inside tmux
    # git.paging.colorArg = "always";
    # git.paging.pager = "delta --dark --paging=never";
  };

  home.homeDirectory = "/home/kmicklas";
  home.username = "kmicklas";

  home.stateVersion = "22.11";
}
