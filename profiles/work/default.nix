{ pkgs, lib, ... }:

{
  imports = [
    ../../user/base

    ../../user/git.nix
    ../../user/go.nix
    ../../user/rust.nix
  ] ++ lib.optionals (builtins.pathExists ../../../local-config) [
    ../../../local-config
  ];

  home.sessionVariables = {
    NIX_PATH = "$NIX_PATH\${NIX_PATH:+:}nixpkgs=${builtins.toPath ../../dep/nixpkgs}";
  };

  programs.git.extraConfig = {
    "url \"https://github.com/\"".insteadOf = [
      "git@github.com:"
      "ssh://git@github.com:"
    ];
  };
  programs.git.package = lib.mkForce (pkgs.gitAndTools.gitFull.override {
    openssh = pkgs.opensshWithKerberos;
  });

  home.packages = with pkgs; [
    dive
    nix
  ];
}
