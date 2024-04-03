{ pkgs, ... }:

{
  home.packages = with pkgs; [
    go
    gofumpt
    golangci-lint
    golint
    gopls
    gotools

    gcc
  ];

  home.sessionPath = [ "$HOME/go/bin" ];
}
