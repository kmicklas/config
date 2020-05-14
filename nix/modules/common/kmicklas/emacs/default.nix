{ lib, pkgs, ... }:

# For reasons I dont't understand there is infinite recursion if I take pkgs as
# a parameter.
let isDarwin = (import <nixpkgs> {}).stdenv.isDarwin;

in {
  imports = [
    ./module.nix
  ];

  programs.emacs.enable = true;
  home.sessionVariables.EDITOR = "emacsclient --create-frame --tty";
  home.sessionVariables.VISUAL = "emacsclient --create-frame";

  home.file.".spacemacs".source = ../../../../../dotfiles/spacemacs;
  home.file.".emacs.d/spacemacs".source = ../../../../../dep/spacemacs;
  home.file.".emacs.d/spacemacs.el".text = ''
    (setq spacemacs-start-directory "~/.emacs.d/spacemacs/")
    (load-file (concat spacemacs-start-directory "init.el"))
  '';

  programs.emacs.init = {
    enable = true;
    recommendedGcSettings = true;

    prelude = lib.concatStringsSep "\n" [
      (builtins.readFile ./prelude.el)
      (lib.optionalString isDarwin ''
        (setq
          mac-command-modifier 'control
          mac-option-modifier 'meta
          mac-control-modifier nil)
      '')
    ];

    postlude = builtins.readFile ./postlude.el;

    usePackage = {

      # TODO: Get spacemacs-theme to work.
      ample-theme = {
        enable = true;
      };

      # TODO: Use Google-official bazel-mode.
      bazel-mode = {
        enable = true;
      };

      company = {
        enable = true;
        diminish = [ "company-mode" ];
        config = ''
          (global-company-mode)
        '';
      };

      company-lsp = {
        enable = true;
        after = [ "company" "lsp-mode" ];
      };

      csv-mode = {
        enable = true;
      };

      direnv = {
        enable = true;
        config = ''
          (direnv-mode)
        '';
      };

      editorconfig = {
        enable = true;
      };

      evil = {
        enable = true;
        config = ''
          (evil-mode 1)
        '';
      };

      evil-collection = {
        enable = true;
        after = [ "evil" ];
      };

      evil-escape = {
        enable = true;
        after = [ "evil" ];
        diminish = [ "evil-escape-mode" ];
        config = ''
          (evil-escape-mode 1)
        '';
      };

      evil-magit = {
        enable = true;
        after = [ "magit" ];
      };

      evil-org = {
        enable = true;
        after = [ "evil" "org" ];
      };

      forge = {
        enable = true;
        after = [ "magit" ];
      };

      helm = {
        enable = true;
        config = ''
          (setq
            helm-mode-fuzzy-match t
            helm-M-x-fuzzy-match t
            )
        '';
      };

      helm-projectile = {
        enable = true;
        after = [ "helm" "projectile" ];
        config = ''
          (setq helm-ag-base-command "${pkgs.ag}/bin/ag --nocolor --nogroup")
        '';
      };

      general = {
        enable = true;
        after = [ "evil" "which-key" ];
        config = ''
          (eval-when-compile (general-evil-setup))
        '';
      };

      go-mode = {
        enable = true;
      };

      haskell-mode = {
        enable = true;
      };

      json-mode = {
        enable = true;
      };

      js2-mode = {
        enable = true;
      };

      keyfreq = {
        enable = true;
        config = ''
          (keyfreq-mode 1)
          (keyfreq-autosave-mode 1)
        '';
      };

      lsp-mode = {
        enable = true;
      };

      lsp-ui = {
        enable = true;
        after = [ "lsp-mode" ];
      };

      magit = {
        enable = true;
      };

      markdown-mode = {
        enable = true;
      };

      nix-buffer = {
        enable = true;
      };

      nix-mode = {
        enable = true;
        config = ''
          (setq nix-nixfmt-bin "${pkgs.nixfmt}/bin/nixfmt")
        '';
      };

      nix-update = {
        enable = true;
      };

      org = {
        enable = true;
        config = ''
          (setq
            org-agenda-files (file-expand-wildcards "~/*/*.org")
            org-fontify-done-headline t
            )
        '';
      };

      perspective = {
        enable = true;
        config = ''
          (persp-mode)
          (setq persp-state-default-file "~/.emacs.d/perspectives")
          (add-hook 'kill-emacs-hook #'persp-state-save)
        '';
      };

      persp-projectile = {
        enable = true;
        after = [ "perspective" "projectile" ];
      };

      projectile = {
        enable = true;
        after = [ "helm" ];
        diminish = [ "projectile-mode" ];
        config = ''
          (projectile-mode 1)
          (setq
            projectile-enable-caching t
            projectile-require-project-root nil
            projectile-completion-system 'helm
            )
          (add-to-list 'projectile-globally-ignored-files ".DS_Store")
        '';
      };

      protobuf-mode = {
        enable = true;
      };

      python = {
        enable = true;
      };

      rust-mode = {
        enable = true;
      };

      sudo-edit = {
        enable = true;
      };

      thrift = {
        enable = true;
      };

      which-key = {
        enable = true;
        diminish = [ "which-key-mode" ];
        config = ''
          (which-key-mode)
          (setq
            which-key-sort-order 'which-key-key-order-alpha
            which-key-idle-delay 0.05
            )
        '';
      };

      yaml-mode = {
        enable = true;
      };

    };
  };
} // lib.optionalAttrs (!isDarwin) {
  services.emacs.enable = true;
}
