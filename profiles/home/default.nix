{ pkgs, ... }:

{
  imports = [
    ../../user/base
    ../../user/graphical

    ../../user/emacs
    ../../user/git.nix
    ../../user/go.nix
    ../../user/haskell.nix
    ../../user/ssh.nix
    ../../user/rust.nix
  ];

  programs.git.userEmail = "git@kmicklas.com";
  programs.git.extraConfig = {
    # TODO: Auto-generate these.
    "url \"ssh://git@github.com\"".insteadOf = "https://github.com";
    "url \"ssh://git@gitlab.com\"".insteadOf = "https://gitlab.com";
    "url \"ssh://git@bitbucket.com\"".insteadOf = "https://bitbucket.com";
  };

  home.packages = with pkgs; [
    wally-cli
  ];
}
