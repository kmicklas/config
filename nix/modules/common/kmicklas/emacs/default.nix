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

  home.packages = with pkgs; [
    # direnv-mode doesn't seem to have a variable to get this except from $PATH.
    direnv
  ];

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
        init = ''
          (setq evil-want-keybinding nil)
        '';
        config = ''
          (setq
            evil-cross-lines t
            evil-move-beyond-eol t
            evil-move-cursor-back nil
            evil-want-Y-yank-to-eol t
            )
          (evil-mode 1)
        '';
      };

      evil-collection = {
        enable = true;
        after = [ "company" "evil" "magit-todos" ];
        config = ''
          (require 'company-tng)
          (evil-collection-init)
        '';
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

      flycheck = {
        enable = true;
      };

      forge = {
        enable = true;
        after = [ "magit" ];
      };

      helm = {
        enable = true;
        config = ''
          (require 'helm-config)
          (setq
            helm-mode-fuzzy-match t
            helm-M-x-fuzzy-match t
            )
          (helm-mode)
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

      hydra = {
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

      lsp-haskell = {
        after = [ "lsp-mode" ];
        enable = true;
        config = ''
          (setq
            lsp-haskell-process-path-hie "ghcide"
            lsp-haskell-process-args-hie '()
            )
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

      magit-todos = {
        after = [ "magit" ];
        enable = true;
        config = ''
          (magit-todos-mode)
        '';
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

          ;; See https://github.com/nex3/perspective-el/issues/128#issuecomment-627041576
          (ad-deactivate 'persp-init-frame)
        '';
      };

      persp-projectile = {
        enable = true;
        after = [ "perspective" "projectile" ];
      };

      # TODO: Consider switching to window-purpose.
      popwin = {
        enable = true;
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
            projectile-git-submodule-command nil
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

      yasnippet = {
        enable = true;
      };

    };
  };
} // lib.optionalAttrs (!isDarwin) {
  services.emacs.enable = true;
}
