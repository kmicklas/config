{ pkgs, ... }:

{
  home.packages = with pkgs; [
    go
    gofumpt
    golangci-lint
    golint
    gotools

    gcc
  ];

  home.sessionPath = [ "$HOME/go/bin" ];
}
