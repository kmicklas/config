{ lib, ... }:

# For reasons I dont't understand there is infinite recursion if I take pkgs as
# a parameter.
let pkgs = import <nixpkgs> {};

in {
  imports = [
    (import ../../../../../dep/rycee-nur {}).hmModules.emacs-init
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

    prelude = builtins.readFile ./prelude.el;

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

      evil-escape = {
        enable = true;
        after = [ "evil" ];
        config = ''
          (evil-escape-mode 1)
        '';
      };

      evil-magit = {
        enable = true;
        after = [ "magit" ];
      };

      forge = {
        enable = true;
        after = [ "magit" ];
      };

      helm = {
        enable = true;
        after = [ "general" ];
        config = ''
          (setq helm-mode-fuzzy-match t)
          (setq helm-M-x-fuzzy-match t)
          (general-nmap
            :prefix "SPC"
            "SPC" '(helm-M-x :which-key "execute")
            "bb" '(helm-mini :which-key "switch")
            "fr" '(helm-recentf :which-key "recent")
            )
        '';
      };

      helm-projectile = {
        enable = true;
        after = [ "helm" "projectile" "general" ];
        config = ''
          (general-nmap
            :prefix "SPC"
            "pf" '(helm-projectile-find-file :which-key "find file")
            )
        '';
      };

      general = {
        enable = true;
        after = [ "evil" "which-key" ];
        config = ''
          (eval-when-compile (general-evil-setup))

          (general-nmap
            "." 'evil-window-next
            "f" 'evil-avy-goto-char
            "F" 'evil-avy-goto-char2
            )
          (general-mmap
            ";" 'evil-ex
            ":" 'evil-repeat-find-char
            )
          (general-create-definer my-leader-def
            :prefix "SPC")
          (general-create-definer my-local-leader-def
            :prefix "SPC m")
          (general-nmap
            :prefix "SPC"

            "b"  '(:ignore t :which-key "buffer")
            "bd" '(kill-this-buffer :which-key "delete")

            "d" '(dired-other-window :which-key "dired")

            "f"  '(:ignore t :which-key "file")
            "ff" '(find-file :which-key "find")
            "fs" '(save-buffer :which-key "save")

            "m"  '(:ignore t :which-key "mode")

            "t"  '(:ignore t :which-key "toggle")
            "tf" '(toggle-frame-fullscreen :which-key "fullscreen")

            "w"  '(:ignore t :which-key "window")
            "wv" 'split-window-horizontally
            "ws" 'split-window-vertically
            "wd" '(delete-window :which-key "delete")
            )
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
        after = [ "general" ];
        config = ''
          (general-nmap
            :prefix "SPC"
            "fb" '(magit-blame :which-key "git blame")
            "g" '(magit-status :which-key "magit")
            )
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
          (persp-mode)
          (setq persp-state-default-file "~/.emacs.d/perspectives")
          (add-hook 'kill-emacs-hook #'persp-state-save)
        '';
      };

      persp-projectile = {
        enable = true;
        after = [ "general" "perspective" "projectile" ];
        config = ''
          (general-nmap
            :prefix "SPC"
            "pp" '(projectile-persp-switch-project :which-key "perspective")
            )
        '';
      };

      projectile = {
        enable = true;
        after = [ "general" "helm" ];
        diminish = [ "projectile-mode" ];
        config = ''
          (projectile-mode 1)
          (setq projectile-enable-caching t)
          (setq projectile-require-project-root nil)
          (setq projectile-completion-system 'helm)
          (add-to-list 'projectile-globally-ignored-files ".DS_Store")

          (general-nmap
            :prefix "SPC"
            "p"  '(:ignore t :which-key "project")
            "pa" '(projectile-add-known-project :which-key "add")
            "pi" '(projectile-invalidate-cache :which-key "invalidate cache")
            "pl" '(projectile-switch-project :which-key "load")
            "ps" '(helm-do-ag-project-root :which-key "search in project")
            )
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

      which-key = {
        enable = true;
        diminish = [ "which-key-mode" ];
        config = ''
          (which-key-mode)
          (setq which-key-sort-order 'which-key-key-order-alpha
                which-key-idle-delay 0.05)
        '';
      };

      yaml-mode = {
        enable = true;
      };

    };
  };
} // lib.optionalAttrs (!pkgs.stdenv.isDarwin) {
  services.emacs.enable = true;
}
