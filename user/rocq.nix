{ pkgs, ... }:

{
  home.packages = [
    pkgs.coq
  ];

  programs.emacs.extraPackages = epkgs: [
    epkgs.proof-general
  ];
}
