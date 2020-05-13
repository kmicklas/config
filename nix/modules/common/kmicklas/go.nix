{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gocode
    godef
    gogetdoc
    goimports
    golangci-lint
    golint
    gometalinter
    gomodifytags
    gopkgs
    gotests
    impl
  ];
}
