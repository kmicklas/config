{ pkgs, ... }:

let
  source = import ../../nix/sources.nix { };

in {
  home.packages = [
    (pkgs.rustPlatform.buildRustPackage {
      name = "git-global-status";
      src = source.git-global-status;
      cargoHash = "sha256-gN6gfohmtdlX5aN+ZPsZmxiqTTQ2EocWJ9600M4sKQE=";
    })
  ];
}
