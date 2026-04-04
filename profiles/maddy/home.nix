{ pkgs, ... }:

{
  imports = [
    ./emacs-init.nix
    ./anki.nix
    ./mpv.nix
    ../../user/base/home-manager.nix # TODO: clean up
  ];

  nixpkgs.config = import ./nix-config.nix;

  home.stateVersion = "22.05";
  home.homeDirectory = "/home/maddy";
  home.username = "maddy";

  home.sessionVariables = {
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];
    
  home.packages = with pkgs; [
    (hunspellWithDicts [ hunspellDicts.en-us-large ])
    acpi
    anki
    arandr
    autorandr
    calibre
    dmenu
    element-desktop
    firefox
    gcc
    geoclue2
    gnome-screenshot
    nautilus
    google-chrome
    htop
    kdePackages.konsole     
    libreoffice
    pavucontrol
    pdftk
    redshift
    ripgrep
    signal-desktop
    tmux
    tor-browser
    transmission_4-gtk
    unar
    unzip
    vim
    vlc
    wget
    xclip
    yt-dlp
    zoom-us

    (gimp-with-plugins.override { plugins = with gimpPlugins; [ gmic ]; })
    gplates
    inkscape

    dune_3
    ocaml
    ocamlformat
    ocamlPackages.findlib
    ocamlPackages.core
    
    ghc
    cabal-install
    binutils
    stylish-haskell
    haskellPackages.cabal-fmt

    rustup
    pkg-config
    cargo-binstall
    
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
  
  services.redshift = {
    enable = true;
    provider = "geoclue2";
  };

  xresources.properties."Xft.dpi" = 128;

  xsession.enable = true;
  xsession.initExtra = ''
    ibus-daemon &
  '';
  xsession.windowManager.xmonad.enable = true;
  xsession.windowManager.xmonad.enableContribAndExtras = true;
  xsession.windowManager.xmonad.config = ./xmonad.hs;

  home.sessionVariables = {
    GTK_IM_MODULE = "ibus";
    QT_IM_MODULE = "ibus";
    XMODIFIERS = "@im=ibus";
  };
}
