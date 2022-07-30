{ pkgs, ... }:

{
  home.packages = with pkgs; [
    go_1_18
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

  home.sessionPath = [ "$HOME/go/bin" ];
}
