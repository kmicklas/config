{ pkgs, ... }:

{
  home.file.".cargo/config".text = ''
    [net]
    git-fetch-with-cli = true
  '';

  home.packages = with pkgs; [
    cargo-edit
    rustup
    rust-analyzer
  ];

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];
}
