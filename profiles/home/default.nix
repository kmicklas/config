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

  programs.git.userEmail = "git@kmicklas.com";
  programs.git.extraConfig = {
    # TODO: Auto-generate these.
    "url \"ssh://git@github.com\"".insteadOf = "https://github.com";
    "url \"ssh://git@gitlab.com\"".insteadOf = "https://gitlab.com";
    "url \"ssh://git@bitbucket.com\"".insteadOf = "https://bitbucket.com";
  };

  # TODO: Remove once upgrading to 24.05.
  programs.atuin.package = nixpkgs-unstable.atuin.overrideAttrs (self: {
    # TODO: Remove once https://github.com/openzfs/zfs/issues/14290 is fixed.
    patches = self.patches ++ [ ./atuin-zfs.patch ];
  });
}
