{ lib, nixpkgsConfig, pkgs, ... }:

{
  xdg.configFile."nixpkgs/config.nix".text = lib.generators.toPretty {} nixpkgsConfig;

  programs.nix-index.enable = true;

  programs.direnv.nix-direnv.enable = true;

  services.lorri.enable = true;

  home.packages = with pkgs; [
    cachix
    niv
    nixfmt-classic
    nix-tree
  ];
}
