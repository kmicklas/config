{ pkgs, ... }:

{
  home.file.".cargo/config".text = ''
    [net]
    git-fetch-with-cli = true
  '';

  home.packages = with pkgs; [
    cargo
    cargo-edit
    rustc
    rust-analyzer
  ];
}
