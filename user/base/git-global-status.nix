{ pkgs, ... }:

let
  source = import ../../nix/sources.nix { };

in {
  home.packages = [
    (pkgs.rustPlatform.buildRustPackage {
      name = "git-global-status";
      src = source.git-global-status;
      cargoHash = "sha256-4ih33jfJXTTluzIzM3ag0PAsQsB9rjcQj6eCls8Z7No=";
    })
  ];
}
