{ pkgs, ... }:

let
  source = import ../nix/sources.nix { };
  nixpkgs-unstable = import source.nixpkgs-unstable { };

in {
  programs.git.enable = true;
  programs.git.package = pkgs.gitAndTools.gitFull;
  programs.git.userName = "Ken Micklas";
  programs.git.extraConfig = {
    merge.conflictStyle = "zdiff3";
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
    ".projectile"
    ".direnv/"
  ];
  programs.git.delta.enable = true;

  # TODO(25.04): Use home-manager mergiraf module.
  programs.git.attributes = [ "* merge=mergiraf" ];
  programs.git.extraConfig = {
    merge.mergiraf = {
      name = "mergiraf";
      driver = "${nixpkgs-unstable.mergiraf} merge --git %O %A %B -s %S -x %X -y %Y -p %P -l %L";
    };
  };

  home.packages = with pkgs; [
    gh
    git-delete-merged-branches
  ];
}
