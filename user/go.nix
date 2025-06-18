{ pkgs, ... }:

{
  home.packages = with pkgs; [
    go
    gofumpt
    golangci-lint
    golint
    gopls
    (hiPrio gotools)
  ];

  home.sessionPath = [ "$HOME/go/bin" ];
}
