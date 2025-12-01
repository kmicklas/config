{ config, lib, pkgs, ... }:

{
  imports = [
    ../../user/base

    ../../user/git.nix
    ../../user/go.nix
    ../../user/rust
  ] ++ lib.optionals (builtins.pathExists ../../../local-config) [
    ../../../local-config
  ];

  home.sessionVariables = {
    NIX_PATH = "$NIX_PATH\${NIX_PATH:+:}nixpkgs=${builtins.toPath ../../dep/nixpkgs}";
  };

  # Recently programs such as git seemed to have stopped reading non-Nix
  # managed terminfo.
  home.file.".terminfo".source = config.lib.file.mkOutOfStoreSymlink "/usr/share/terminfo";

  programs.git.settings = {
    "url \"https://github.com/\"".insteadOf = [
      "git@github.com:"
      "ssh://git@github.com:"
    ];
  };
  programs.git.package = lib.mkForce (pkgs.gitFull.override {
    openssh = pkgs.opensshWithKerberos;
  });

  home.packages = with pkgs; [
    dive
    nix
  ];
}
