{ pkgs, ... }:

let
  nixpkgsConfig = ../../../../dotfiles/config/nixpkgs/config.nix;
in

{
  nixpkgs.config = import nixpkgsConfig;
  xdg.configFile."nixpkgs/config.nix".source = nixpkgsConfig;

  home.packages = with pkgs; [
    cachix
    (haskellPackages.extend (self: super: {
      cli-extras = haskell.lib.doJailbreak super.cli-extras;
      cli-git = haskell.lib.doJailbreak super.cli-git;
      cli-nix = haskell.lib.doJailbreak super.cli-nix;
      nix-thunk = haskell.lib.doJailbreak super.nix-thunk;
    })).nix-thunk
    nix-tree
  ];
}
