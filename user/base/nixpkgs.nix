{ pkgs, ... }:

let
  nixpkgsConfig = ../../dotfiles/config/nixpkgs/config.nix;
in

{
  nixpkgs.config = import nixpkgsConfig;
  xdg.configFile."nixpkgs/config.nix".source = nixpkgsConfig;

  programs.nix-index.enable = true;

  services.lorri.enable = true;

  home.packages = with pkgs; [
    cachix
    niv
    nixfmt-classic
    nix-tree
  ];
}
