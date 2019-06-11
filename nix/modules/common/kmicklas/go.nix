{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gocode
    godef
    gogetdoc
    goimports
    golangci-lint
    gometalinter
    gomodifytags
    gopkgs
    gotests
    impl
  ];
}
