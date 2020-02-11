{ pkgs, ... }:

let
  nixpkgsConfig = ../../../../dotfiles/config/nixpkgs/config.nix;
in

{
  nixpkgs.config = import nixpkgsConfig;
  xdg.configFile."nixpkgs/config.nix".source = nixpkgsConfig;

  home.packages = with pkgs; [
    cachix
  ];
}
