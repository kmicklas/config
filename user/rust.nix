{ pkgs, ... }:

{
  home.file.".cargo/config.toml".text = ''
    [net]
    git-fetch-with-cli = true
  '';

  home.packages = with pkgs; [
    bacon
    cargo-edit
    lldb
    rustup
    trunk
  ];

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];
}
