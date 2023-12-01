{ pkgs, ... }:

{
  home.packages = with pkgs; [
    go
    gocode
    godef
    gofumpt
    gogetdoc
    golangci-lint
    golint
    gomodifytags
    gopkgs
    gotests
    gotools
    impl

    gcc
  ];

  home.sessionPath = [ "$HOME/go/bin" ];
}
