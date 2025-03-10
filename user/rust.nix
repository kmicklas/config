{ pkgs, ... }:

{
  home.file.".cargo/config.toml".text = ''
    [net]
    git-fetch-with-cli = true
  '';

  home.packages = with pkgs; [
    bacon
    cargo-binstall
    cargo-edit
    cargo-insta
    cargo-nextest
    gcc # TODO: use clang, but conflict with binutils
    lldb
    rustup
    trunk
  ];

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];
}
