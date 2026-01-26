{ pkgs, ... }:

{
  programs.git.enable = true;
  programs.git.package = pkgs.gitFull;
  programs.git.settings = {
    user.name = "Ken Micklas";
    github.user = "kmicklas";

    mergeTool.keepBackup = false;
    push.autoSetupRemote = true;
    push.default = "simple";
    pull.ff = "only";
    fetch.all = true;
    fetch.prune = true;
    fetch.pruneTags = true;

    # See https://github.com/rust-lang/cargo/issues/11857
    # and https://github.com/libgit2/libgit2/issues/6531
    # feature.manyFiles = true;

    init.defaultBranch = "main";

    # https://github.com/killercup/cargo-edit/issues/687
    "url \"https://github.com/rust-lang/crates.io-index\"".insteadOf =
      "https://github.com/rust-lang/crates.io-index";

    # https://github.blog/2021-09-01-improving-git-protocol-security-github/#no-more-unauthenticated-git
    "url \"https://github.com/\"".insteadOf = [ "git://github.com/" ];
  };
  programs.git.ignores = [
    "*~"
    ".claude/settings.local.json"
    ".direnv/"
    ".projectile"
  ];

  programs.delta.enable = true;
  programs.delta.enableGitIntegration = true;

  programs.mergiraf.enable = true;

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

  home.packages = with pkgs; [
    gh
    git-delete-merged-branches
  ];
}
