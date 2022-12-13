{ pkgs, ... }:

{
  programs.git.enable = true;
  programs.git.package = pkgs.gitAndTools.gitFull;
  programs.git.userName = "Ken Micklas";
  programs.git.extraConfig = {
    mergeTool.keepBackup = false;
    push.default = "simple";
    pull.ff = "only";
    feature.manyFiles = true;

    github.user = "kmicklas";

    init.defaultBranch = "main";

    # https://github.com/killercup/cargo-edit/issues/687
    "url \"https://github.com/rust-lang/crates.io-index\"".insteadOf =
      "https://github.com/rust-lang/crates.io-index";

    # https://github.blog/2021-09-01-improving-git-protocol-security-github/#no-more-unauthenticated-git
    "url \"https://github.com/\"".insteadOf = "git://github.com/";
  };
  programs.git.ignores = [
    "*~"
    ".projectile"
    "/.direnv/"
  ];
  programs.git.delta.enable = true;

  home.packages = with pkgs; [
    gh
    git-delete-merged-branches
  ];
}
