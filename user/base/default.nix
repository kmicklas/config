{ pkgs, ... }:

let
  source = import ../../nix/sources.nix { };
  nixpkgs-unstable = import source.nixpkgs-unstable { };

in {
  imports = [
    ./home-manager.nix
    ./helix.nix
    ./nixpkgs.nix
    ./tmux.nix
    ./zsh.nix
  ];

  home.sessionPath = [
    "$HOME/.local/bin"
    (builtins.toPath ../../bin)
  ];

  home.packages = (with pkgs; [
    dua
    gex
    htop
    hyperfine
    jqp
    ripgrep
    tree
    yazi
  ]) ++ [
    nixpkgs-unstable.aider-chat
  ];

  programs.bat.enable = true;

  programs.eza.enable = true;
  programs.eza.enableBashIntegration = true;
  programs.eza.enableZshIntegration = true;

  programs.fzf.enable = true;

  programs.jq.enable = true;

  programs.lazygit.enable = true;
  programs.lazygit.settings = {
    # TODO: Get delta colors working properly inside tmux
    # git.paging.colorArg = "always";
    # git.paging.pager = "delta --dark --paging=never";

    git.commit.autoWrapCommitMessage = false;

    customCommands = [
      {
        # TODO: Fix force pushing issue upstream.
        key = "<c-f>";
        description = "force push";
        context = "global";
        command = "git push --force-with-lease {{.Form.Remote}} {{.Form.Ref}}";

        prompts = [
          {
            type = "input";
            title = "Remote:";
            key = "Remote";
            initialValue = "{{.SelectedRemote.Name}}";
          }
          {
            type = "input";
            title = "Ref:";
            key = "Ref";
            initialValue = "HEAD";
          }
        ];
      }
    ];
  };

  home.homeDirectory = "/home/kmicklas";
  home.username = "kmicklas";

  home.stateVersion = "23.05";
}
