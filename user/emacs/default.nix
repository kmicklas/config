{ config, lib, pkgs, ... }:

# For reasons I dont't understand there is infinite recursion if I take pkgs as
# a parameter.
let isDarwin = (import <nixpkgs> {}).stdenv.isDarwin;

in {
  imports = [
    ./module.nix
  ];

  programs.emacs.enable = true;
  programs.emacs.package = pkgs.emacs29;

  home.packages = with pkgs; [
    # direnv-mode doesn't seem to have a variable to get this except from $PATH.
    direnv
    (hunspellWithDicts [ hunspellDicts.en-us-large ])
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

      all-the-icons = {
        enable = true;
      };

      # TODO: Get spacemacs-theme to work.
      ample-theme = {
        enable = true;
        config = ''
          (ample-theme)
        '';
      };

      anzu = {
        enable = true;
      };

      avy = {
        enable = true;
      };

      bazel = {
        enable = true;
      };

      cargo = {
        enable = true;
        after = [ "rust-mode" ];
        config = ''
          (add-hook 'rust-mode-hook 'cargo-minor-mode)
        '';
      };

      clipetty = {
        enable = true;
        config = ''
          (global-clipetty-mode)
        '';
      };

      company = {
        enable = true;
        diminish = [ "company-mode" ];
        config = ''
          (global-company-mode)
        '';
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

      dockerfile-mode = {
        enable = true;
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
          (evil-set-undo-system 'undo-tree)
          (evil-mode 1)
        '';
      };

      evil-collection = {
        enable = true;
        after = [ "company" "evil" "magit" ] ++ lib.optional config.programs.emacs.init.usePackage.magit-todos.enable "magit-todos";
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
          (setq evil-escape-delay 0.5)
          (evil-escape-mode 1)
        '';
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

      format-all = {
        enable = true;
      };

      fullframe = {
        enable = true;
        after = [ "magit" ];
        config = ''
          (fullframe magit-status magit-mode-quit-window)
        '';
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

      groovy-mode = {
        enable = true;
      };

      haskell-mode = {
        enable = true;
      };

      helm = {
        enable = true;
        config = lib.optionalString (!isDarwin) ''
          (add-to-list 'completion-styles 'flex)
        '' + ''
          (helm-mode)
        '';
      };

      helm-projectile = {
        enable = true;
        after = [ "helm" "projectile" ];
      };

      helm-rg = {
        enable = true;
        after = [ "helm" ];
      };

      hydra = {
        enable = true;
      };

      json-mode = {
        enable = true;
      };

      js2-mode = {
        enable = true;
        config = ''
          (setq js-indent-level 2)
        '';
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
      };

      lsp-mode = {
        enable = true;
        config = ''
          (setq
            lsp-prefer-flymake nil
            lsp-nix-server-path "${pkgs.rnix-lsp}/bin/rnix-lsp"
            )
        '';
      };

      lsp-pyright = {
        enable = true;
        after = [ "lsp-mode" ];
      };

      lsp-ui = {
        enable = true;
        after = [ "lsp-mode" ];
      };

      lua-mode = {
        enable = true;
      };

      magit = {
        enable = true;
        config = ''
          (setf (alist-get 'unpushed magit-section-initial-visibility-alist) 'show)
          (setf (alist-get 'stashes magit-section-initial-visibility-alist) 'show)

          (remove-hook 'magit-status-sections-hook 'magit-insert-tags-header)
          (remove-hook 'magit-status-sections-hook 'magit-insert-status-headers)

          (setq magit-log-section-commit-count 5)
        '';
      };

      magit-delta = {
        enable = true;
        after = [ "magit" ];
        config = ''
          (setq magit-delta-delta-executable "${pkgs.delta}/bin/delta")
          (add-hook 'magit-mode-hook (lambda () (magit-delta-mode 1)))
        '';
      };

      magit-todos = {
        after = [ "magit" ];
        enable = !isDarwin;
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
          (setq
            persp-state-default-file "~/.emacs.d/perspectives"
            persp-suppress-no-prefix-key-warning t
            )
          (persp-mode)
          (add-hook 'kill-emacs-hook #'persp-state-save)
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
        config = ''
          (setq python-indent-def-block-scale 1)
        '';
      };

      rg = {
        enable = true;
        config = ''
          (rg-enable-default-bindings)
        '';
      };

      rust-mode = {
        enable = true;
        config = ''
          (setq rust-format-on-save t)
        '';
      };

      smartparens = {
        enable = true;
        config = ''
          (require 'smartparens-config)
          (add-hook 'prog-mode-hook 'smartparens-mode)
        '';
      };

      # TODO: Switch to native SQLite in Emacs 29.
      sqlite3 = {
        enable = true;
      };

      sudo-edit = {
        enable = true;
      };

      treesit-grammars = {
        enable = true;
        package = epkgs: epkgs.treesit-grammars.with-all-grammars;
      };

      tuareg = {
        enable = true;
      };

      undo-tree = {
        enable = true;
        config = ''
          (global-undo-tree-mode)
        '';
      };

      uuidgen = {
        enable = true;
      };

      vterm = {
        enable = true;
        config = ''
          (add-hook 'vterm-mode-hook (lambda () (setq show-trailing-whitespace nil)))
        '';
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
        config = ''
          (yas-global-mode)
        '';
      };

      yasnippet-snippets = {
        enable = true;
        after = [ "yasnippet" ];
      };

      zig-mode = {
        enable = true;
      };
    };
  };
} // lib.optionalAttrs (!isDarwin) {
  services.emacs.enable = true;
}
