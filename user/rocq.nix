{ pkgs, ... }:

{
  home.packages = [
    pkgs.coq
    pkgs.coqPackages.vscoq-language-server
  ];

  programs.emacs.extraPackages = epkgs: [
    epkgs.proof-general
  ];
}
