{ pkgs, ... }:

{
  imports = [
    ./atuin.nix
    ./git-global-status.nix
    ./helix.nix
    ./home-manager.nix
    ./nixpkgs.nix
    ./tmux.nix
    ./zsh.nix
  ];

  home.sessionPath = [
    "$HOME/.local/bin"
    (builtins.toPath ../../bin)
  ];

  home.shell.enableShellIntegration = true;

  home.packages = with pkgs; [
    dua
    hyperfine
    just
    just-lsp
    tree
    typos
  ];

  programs.bat.enable = true;
  programs.eza.enable = true;
  programs.fd.enable = true;
  programs.fzf.enable = true;
  programs.htop.enable = true;
  programs.jq.enable = true;
  programs.jqp.enable = true;
  programs.ripgrep.enable = true;

  programs.yazi.enable = true;
  programs.yazi.shellWrapperName = "y";
  programs.yazi.keymap = {
    mgr.prepend_keymap = [
      {
        on = [ "g" "b" ];
        run = "cd ~/Dropbox";
        desc = "Go to Dropbox";
      }
    ];
  };

  home.homeDirectory = "/home/kmicklas";
  home.username = "kmicklas";

  home.stateVersion = "23.05";
}
