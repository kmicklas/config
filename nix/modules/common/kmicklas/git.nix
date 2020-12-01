{ pkgs, ... }:

{
  programs.git.enable = true;
  programs.git.package = pkgs.gitAndTools.gitFull;
  programs.git.userName = "Ken Micklas";
  programs.git.userEmail = "git@kmicklas.com";
  programs.git.extraConfig = {
    mergeTool.keepBackup = false;
    push.default = "simple";
    pull.ff = "only";

    github.user = "kmicklas";

    # TODO: Auto-generate these.
    "url \"ssh://git@github.com\"".insteadOf = "https://github.com";
    "url \"ssh://git@gitlab.com\"".insteadOf = "https://gitlab.com";
    "url \"ssh://git@bitbucket.com\"".insteadOf = "https://bitbucket.com";
  };
  programs.git.ignores = [
    "*~"
  ];
  programs.git.delta.enable = true;

  home.packages = with pkgs; [
    gitAndTools.hub
  ];
}
