{ pkgs, ... }:

{
  programs.git.enable = true;
  programs.git.package = pkgs.gitAndTools.gitFull;
  programs.git.userName = "Ken Micklas";
  programs.git.extraConfig = {
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

    github.user = "kmicklas";

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

  programs.git.delta.enable = true;
  programs.mergiraf.enable = true;

  home.packages = with pkgs; [
    gh
    git-delete-merged-branches
  ];
}
