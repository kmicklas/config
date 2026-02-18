{ ... }:

{
  imports = [
    ../../user/base
    ../../user/graphical

    ../../user/dropbox.nix
    ../../user/emacs
    ../../user/git.nix
    ../../user/go.nix
    ../../user/haskell.nix
    ../../user/jujutsu.nix
    ../../user/rust
    ../../user/rust/auto-update.nix
    ../../user/ssh.nix
    ../../user/web
    ../../user/zed
  ];

  programs.git.settings = {
    user.email = "git@kmicklas.com";

    # TODO: Auto-generate these.
    "url \"ssh://git@github.com\"".insteadOf = "https://github.com";
    "url \"ssh://git@gitlab.com\"".insteadOf = "https://gitlab.com";
    "url \"ssh://git@bitbucket.com\"".insteadOf = "https://bitbucket.com";
  };

  programs.jujutsu.settings = {
    user.email = "git@kmicklas.com";
  };

  programs.rclone.enable = true;
}
