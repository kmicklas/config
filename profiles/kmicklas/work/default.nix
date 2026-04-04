{
  config,
  lib,
  pkgs,
  inputs,
  nixpkgsPath,
  ...
}:

{
  imports = [
    ../../../user/base

    ../../../user/git.nix
    ../../../user/go.nix
    ../../../user/jujutsu.nix
    ../../../user/rust
  ];

  home.sessionVariables = {
    NIX_PATH = "$NIX_PATH\${NIX_PATH:+:}nixpkgs=${nixpkgsPath}";
  };
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  nix.registry.nixpkgs-unstable.flake = inputs.nixpkgs-unstable;

  # Recently programs such as git seemed to have stopped reading non-Nix
  # managed terminfo.
  home.file.".terminfo".source = config.lib.file.mkOutOfStoreSymlink "/usr/share/terminfo";

  programs.git.settings = {
    "url \"https://github.com/\"".insteadOf = [
      "git@github.com:"
      "ssh://git@github.com:"
    ];
  };
  programs.git.package = lib.mkForce (
    pkgs.gitFull.override {
      openssh = pkgs.opensshWithKerberos;
    }
  );

  home.packages = with pkgs; [
    dive
    nix
  ];
}
