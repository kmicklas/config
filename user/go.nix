{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    go
    gofumpt
    golangci-lint
    golint
    gopls
    (lib.hiPrio gotools)
  ];

  home.sessionPath = [ "$HOME/go/bin" ];
}
