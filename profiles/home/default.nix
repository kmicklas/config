{ ... }:

{
  imports = [
    ../../user/base
    ../../user/graphical

    ../../user/aider.nix
    ../../user/dropbox.nix
    ../../user/emacs
    ../../user/git.nix
    ../../user/go.nix
    ../../user/haskell.nix
    ../../user/ocaml.nix
    ../../user/rocq.nix
    ../../user/rust.nix
    ../../user/ssh.nix
    ../../user/vscode.nix
  ];

  programs.git.userEmail = "git@kmicklas.com";
  programs.git.extraConfig = {
    # TODO: Auto-generate these.
    "url \"ssh://git@github.com\"".insteadOf = "https://github.com";
    "url \"ssh://git@gitlab.com\"".insteadOf = "https://gitlab.com";
    "url \"ssh://git@bitbucket.com\"".insteadOf = "https://bitbucket.com";
  };
}
