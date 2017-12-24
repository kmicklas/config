pkgs: with pkgs; [
  nix-repl

  wget
  neovim
  python
  gitAndTools.gitFull
  unzip
  tmux

  iotop
  htop
  ncdu
  psmisc # killall
  fuse_exfat
  exfat-utils

  stack
  cabal-install
  haskellPackages.ghcid
]
