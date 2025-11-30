{ pkgs, ... }:

{
  home.file.".cargo/config.toml".source = ./config.toml;

  home.packages = with pkgs; [
    bacon
    cargo-binstall
    cargo-edit
    cargo-fuzz
    cargo-insta
    cargo-nextest
    clang
    lldb
    rustup
    trunk

    # TODO: see if this is fixed in nixpkgs in the future
    (cargo-llvm-cov.overrideAttrs (_: {
      doCheck = false;
    }))
  ];

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];
}
