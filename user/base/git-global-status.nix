{
  pkgs,
  sources,
  ...
}:

{
  home.packages = [
    (pkgs.rustPlatform.buildRustPackage {
      name = "git-global-status";
      src = sources.git-global-status;
      cargoHash = "sha256-Nlk0Z1i9RgccuXr4SwyPorYIvqzRoXaJ6NSTvYEPvoo=";
    })
  ];
}
