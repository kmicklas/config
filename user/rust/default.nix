{ pkgs, ... }:

{
  home.file.".cargo/config.toml".source = ./config.toml;

  home.packages = with pkgs; [
    bacon
    cargo-binstall
    cargo-edit
    cargo-insta
    cargo-llvm-cov
    cargo-nextest
    clang
    lldb
    rustup
    trunk
  ];

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];
}
