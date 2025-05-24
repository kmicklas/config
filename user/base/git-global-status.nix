{ pkgs, ... }:

let
  source = import ../../nix/sources.nix { };

in {
  home.packages = [
    (pkgs.rustPlatform.buildRustPackage {
      name = "git-global-status";
      src = source.git-global-status;
      cargoHash = "sha256-Nlk0Z1i9RgccuXr4SwyPorYIvqzRoXaJ6NSTvYEPvoo=";
    })
  ];
}
