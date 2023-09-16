{ pkgs, ... }:

let
  nixpkgsConfig = ../../dotfiles/config/nixpkgs/config.nix;
in

{
  nixpkgs.config = import nixpkgsConfig;
  xdg.configFile."nixpkgs/config.nix".source = nixpkgsConfig;

  services.lorri.enable = true;

  home.packages = with pkgs; [
    cachix
    niv
    nix-tree
  ];
}
