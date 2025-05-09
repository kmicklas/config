(setq
  inhibit-startup-screen t
  inhibit-startup-message t
  initial-scratch-message nil

  make-backup-files nil
  auto-save-default nil
  undo-tree-auto-save-history nil

  vc-handled-backends '()

  custom-file "~/.emacs.d/custom.el"
)

(setq-default
  c-basic-offset 2
  indent-tabs-mode nil
  next-screen-context-lines 10
  show-trailing-whitespace t
  system-time-locale "C"
  tab-width 2
)

(load custom-file) ;; Without this custom is saved but ignored

(setenv "LANG" "en_US.UTF-8")
(prefer-coding-system 'utf-8)

(when (not window-system) (xterm-mouse-mode 1))

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(blink-cursor-mode 0)
(global-display-line-numbers-mode)
(column-number-mode)
(global-hl-line-mode 1)

(defalias 'yes-or-no-p 'y-or-n-p)

(which-key-mode)

(use-package ample-theme
  :config
  (ample-theme)
)

(use-package consult)

(use-package format-all
  :commands format-all-mode
  :hook (prog-mode . format-all-mode)
)

(use-package treesit-auto
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode)
)

; (use-package nix-mode)
(use-package nix-ts-mode
  :mode "\\.nix\\'"
)

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion))))
)

(use-package rust-mode
  :init
  (setq rust-mode-treesitter-derive t)
)

(use-package git-gutter
  :config
  (global-git-gutter-mode +1)
)

(use-package vertico
  :init
  (vertico-mode)
)
