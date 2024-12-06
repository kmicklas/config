{ ... }:

let
  source = import ../../nix/sources.nix { };
  nixpkgs-unstable = import source.nixpkgs-unstable { };

in {
  imports = [
    ../../user/base
    ../../user/graphical

    ../../user/git.nix
    ../../user/go.nix
    ../../user/haskell.nix
    ../../user/ocaml.nix
    ../../user/ssh.nix
    ../../user/rust.nix
  ];

  home.packages = [
    nixpkgs-unstable.aider-chat
  ];

  programs.git.userEmail = "git@kmicklas.com";
  programs.git.extraConfig = {
    # TODO: Auto-generate these.
    "url \"ssh://git@github.com\"".insteadOf = "https://github.com";
    "url \"ssh://git@gitlab.com\"".insteadOf = "https://gitlab.com";
    "url \"ssh://git@bitbucket.com\"".insteadOf = "https://bitbucket.com";
  };
}
