{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gocode
    godef
    gogetdoc
    goimports
    golangci-lint
    golint
    gomodifytags
    gopkgs
    gotests
    impl
  ];
}
