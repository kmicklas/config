{ pkgs, ... }:

{
  home.file.".cargo/config".text = ''
    [net]
    git-fetch-with-cli = true
  '';

  home.packages = with pkgs; [
    cargo-edit
    rust-analyzer
  ] ++ [
    # TODO: Remove this override when nixpkgs caches rustup again.
    (pkgs.rustup.overrideAttrs (drv: { doCheck = false; }))
  ];

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];
}
