{ pkgs, ... }:

{
  imports = [
    ../../user/graphical

    ../../user/base/home-manager.nix # TODO: clean up
    ../../user/haskell
    ../../user/rust

    ./emacs-init.nix
    ./mpv.nix
  ];

  nixpkgs.config = import ./nix-config.nix;

  home.stateVersion = "22.05";
  home.homeDirectory = "/home/maddy";
  home.username = "maddy";

  home.sessionVariables = {
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };
    
  home.packages = with pkgs; [
    (hunspellWithDicts [ hunspellDicts.en-us-large ])

    gplates

    dune_3
    ocaml
    ocamlformat
    ocamlPackages.findlib
    ocamlPackages.core
    
    jre
  ];

  programs.bash.enable = true;
  programs.bash.sessionVariables = {
    EDITOR = "emacs -nw";
  };
  programs.bash.shellAliases = {
    sleep = "systemctl suspend";
    gproject = "_JAVA_AWT_WM_NONREPARENTING=1 ~/G.ProjectorJ/gprojector.sh";
  };

  programs.git.enable = true;
  programs.git.ignores = [ "*~" ];
  programs.git.settings.user.name = "Maddy Lea";
  programs.git.settings.user.email = "maddy.lea@gmail.com";
  programs.delta.enable = true;

  programs.emacs.enable = true;
  programs.emacs.init = {
    enable = true;

    prelude = builtins.readFile ./prelude.el;
    postlude = builtins.readFile ./postlude.el;

    usePackage = {

      ample-theme = {
        enable = true;
        config = "(ample-theme)";
      };

      haskell-mode = {
        enable = true;
      };

      rust-mode = {
        enable = true;
        config = ''
          (setq rust-format-on-save t)
        '';
      };

      lsp-mode = {
        enable = true;
      };

      lsp-ui = {
        enable = true;
        after = [ "lsp-mode" ];
      };

      flycheck = {
        enable = true;
      };
      
      magit = {
        enable = true;
      };

      nix-mode = {
        enable = true;
      };

      tuareg = {
        enable = true;
      };

      uuidgen = {
        enable = true;
      };

      org = {
        enable = true;
      };

      wc-mode  = {
        enable = true;
      };

      which-key = {
        enable = true;
        config = ''
          (which-key-mode)
        '';
      };

      company = {
        enable = true;
        config = ''
          (global-company-mode)
        '';
      };

    };
  };

  xsession.enable = true;
  xsession.initExtra = ''
    ibus-daemon &
  '';
  xsession.windowManager.xmonad.enable = true;
  xsession.windowManager.xmonad.enableContribAndExtras = true;
  xsession.windowManager.xmonad.config = ./xmonad.hs;
}
