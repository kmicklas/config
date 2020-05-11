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
      };

      evil-magit = {
        enable = true;
        after = [ "magit" ];
      };

      general = {
        enable = true;
        after = [ "evil" "which-key" ];
        config = ''
          (eval-when-compile (general-evil-setup))

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
            "bd" 'kill-this-buffer

            "f"  '(:ignore t :which-key "file")
            "ff" 'find-file
            "fs" 'save-buffer

            "m"  '(:ignore t :which-key "mode")

            "t"  '(:ignore t :which-key "toggle")
            "tf" 'toggle-frame-fullscreen

            "w"  '(:ignore t :which-key "window")
            "wv" 'split-window-horizontally
            "ws" 'split-window-vertically
            "wd" 'delete-window
            )
        '';
      };

      go-mode = {
        enable = true;
      };

      haskell-mode = {
        enable = true;
      };

      ivy = {
        enable = true;
        demand = true;
        diminish = [ "ivy-mode" ];
        after = [ "general" ];
        config = ''
          (ivy-mode 1)
          (setq ivy-use-virtual-buffers t
                ivy-height 20
                ivy-count-format "(%d/%d) "
                ivy-initial-inputs-alist nil)

          (general-nmap
            :prefix "SPC"
            "bb" 'ivy-switch-buffer
            "fr" 'ivy-recentf
            )
        '';
      };

      keyfreq = {
        enable = true;
      };

      magit = {
        enable = true;
        after = [ "general" ];
        config = ''
          (general-nmap
            :prefix "SPC"
            "g" '(:ignore t :which-key "git")
            "gb" 'magit-blame
            "gg" 'magit-status
            )
        '';
      };

      markdown-mode = {
        enable = true;
      };

      nix-mode = {
        enable = true;
      };

      projectile = {
        enable = true;
        after = [ "general" "ivy" ];
        diminish = [ "projectile-mode" ];
        config = ''
          (projectile-mode 1)
          (progn
            (setq projectile-enable-caching t)
            (setq projectile-require-project-root nil)
            (setq projectile-completion-system 'ivy)
            (add-to-list 'projectile-globally-ignored-files ".DS_Store")
            )

          (general-nmap
            :prefix "SPC"
            "p"  '(:ignore t :which-key "project")
            "pf" 'projectile-find-file
            "pi" 'projectile-invalidate-cache
            "pl" 'projectile-switch-project
            )
        '';
      };

      rust-mode = {
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

    };
  };
} // lib.optionalAttrs (!pkgs.stdenv.isDarwin) {
  services.emacs.enable = true;
}
