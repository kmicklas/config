{ config, lib, pkgs, ... }:

# For reasons I dont't understand there is infinite recursion if I take pkgs as
# a parameter.
let isDarwin = (import <nixpkgs> {}).stdenv.isDarwin;

in {
  imports = [
    ./module.nix
    ./spacemacs.nix
  ];

  programs.emacs.enable = true;
  home.sessionVariables.EDITOR = "${config.programs.emacs.package}/bin/emacsclient --create-frame --tty";
  home.sessionVariables.VISUAL = "${config.programs.emacs.package}/bin/emacsclient --create-frame";

  home.packages = with pkgs; [
    # direnv-mode doesn't seem to have a variable to get this except from $PATH.
    direnv
  ];

  programs.emacs.init = {
    enable = true;
    recommendedGcSettings = true;

    prelude = lib.concatStringsSep "\n" [
      (builtins.readFile ./prelude.el)
      (lib.optionalString (!isDarwin) ''
        (add-to-list 'default-frame-alist '(font . "Source Code Pro 8"))
      '')
      (lib.optionalString isDarwin ''
        (add-to-list 'default-frame-alist '(font . "Source Code Pro 18"))

        (setq
          mac-command-modifier 'control
          mac-option-modifier 'meta
          mac-control-modifier nil)
      '')
    ];

    postlude = builtins.readFile ./postlude.el;

    usePackage = {

      all-the-icons = {
        enable = true;
      };

      # TODO: Get spacemacs-theme to work.
      ample-theme = {
        enable = true;
      };

      anzu = {
        enable = true;
      };

      avy = {
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

      doom-modeline = {
        enable = true;
        after = [ "all-the-icons" ];
        config = ''
          (setq
            doom-modeline-height 0
            doom-modeline-buffer-encoding nil
            )
          (doom-modeline-mode 1)
        '';
      };

      editorconfig = {
        enable = true;
        config = ''
          (editorconfig-mode 1)
        '';
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
            evil-want-change-word-to-end nil
            evil-want-Y-yank-to-eol t
            )
          (evil-mode 1)
        '';
      };

      evil-collection = {
        # Upgraded to fix 'j' in magit-todos.
        # TODO: Remove this once evil-collection is updated in nixpkgs.
        package = epkgs: epkgs.evil-collection.overrideAttrs (_: {
          src = import ../../../../../dep/evil-collection/thunk.nix;
        });

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
        config = ''
          (require 'evil-org-agenda)
          (evil-org-agenda-set-keys)
        '';
      };

      expand-region = {
        enable = true;
        config = ''
          (add-to-list 'er/try-expand-list #'mark-paragraph)
        '';
      };

      flycheck = {
        enable = true;
      };

      forge = {
        enable = true;
        after = [ "magit" ];
      };

      general = {
        enable = true;
        after = [ "evil" "which-key" ];
        config = ''
          (eval-when-compile (general-evil-setup))
          (setq general-override-states
            '(insert
              emacs
              hybrid
              normal
              visual
              motion
              operator
              replace
              ))
        '';
      };

      git-gutter = {
        enable = true;
        config = ''
          (global-git-gutter-mode)
        '';
      };

      go-mode = {
        enable = true;
        config = ''
          (add-hook 'before-save-hook 'gofmt-before-save)
        '';
      };

      haskell-mode = {
        enable = true;
      };

      helm = {
        enable = true;
        config = ''
          (require 'helm-config)
          (add-to-list 'completion-styles 'flex)
          (helm-mode)
        '';
      };

      helm-ag = {
        enable = true;
        after = [ "helm" ];
        config = ''
          (setq helm-ag-base-command "${pkgs.ag}/bin/ag --nocolor --nogroup")
        '';
      };

      helm-projectile = {
        enable = true;
        after = [ "helm" "projectile" ];
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

      key-chord = {
        enable = true;
        config = ''
          (key-chord-mode 1)
        '';
      };

      key-seq = {
        enable = true;
        after = [ "key-chord" ];
      };

      lsp-haskell = {
        after = [ "lsp-mode" ];
        enable = true;
        config = ''
          (setq
            lsp-haskell-process-path-hie "${pkgs.haskellPackages.ghcide}/bin/ghcide"
            lsp-haskell-process-args-hie '()
            )
        '';
      };

      lsp-mode = {
        enable = true;
        config = ''
          (setq
            lsp-prefer-flymake nil
            )
        '';
      };

      lsp-ui = {
        enable = true;
        after = [ "lsp-mode" ];
      };

      magit = {
        enable = true;
        config = ''
          (setf (alist-get 'unpushed magit-section-initial-visibility-alist) 'show)
          (setf (alist-get 'stashes magit-section-initial-visibility-alist) 'show)
        '';
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

      modalka = {
        enable = true;
        config = ''
          (setq-default cursor-type '(bar . 1))
          (setq modalka-cursor-type 'box)
          (define-key modalka-mode-map [remap self-insert-command] 'ignore)
        '';
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

      prettier-js = {
        enable = true;
        after = [ "js2-mode" ];
        config = ''
          (setq prettier-js-command "${pkgs.nodePackages.prettier}/bin/prettier")
          (add-hook 'js2-mode-hook 'prettier-js-mode)
        '';
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

      uuidgen = {
        enable = true;
      };

      which-key = {
        enable = true;
        diminish = [ "which-key-mode" ];
        config = ''
          (which-key-mode)
          (setq
            which-key-sort-order 'which-key-key-order-alpha
            which-key-idle-delay 0.1
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
} // lib.optionalAttrs isDarwin {
  programs.emacs.package = pkgs.emacsMacport;
}
