{ pkgs, ... }:

{
  home.packages = with pkgs; [
    go
    gofumpt
    golangci-lint
    golint
    gopls
    gotools
  ];

  home.sessionPath = [ "$HOME/go/bin" ];
}
