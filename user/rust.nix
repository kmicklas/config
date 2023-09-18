{ pkgs, ... }:

{
  home.file.".cargo/config".text = ''
    [net]
    git-fetch-with-cli = true
  '';

  home.packages = with pkgs; [
    cargo-edit
    lldb
    rustup
  ];

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];
}
