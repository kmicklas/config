{ pkgs, ... }:

{
  imports = [
    ./atuin.nix
    ./helix.nix
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
    dua
    gex
    htop
    hyperfine
    jqp
    ripgrep
    tree
  ];

  programs.bat.enable = true;

  programs.eza.enable = true;
  programs.eza.enableBashIntegration = true;
  programs.eza.enableZshIntegration = true;

  programs.yazi.enable = true;
  # TODO: Use this on 24.11.
  # programs.yazi.shellWrapperName = "y";
  programs.yazi.enableBashIntegration = true;
  programs.yazi.enableZshIntegration = true;

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
