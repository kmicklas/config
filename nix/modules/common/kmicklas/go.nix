{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gocode
    godef
    gogetdoc
    golangci-lint
    golint
    gomodifytags
    gopkgs
    gotests
    gotools
    impl
  ];
}
