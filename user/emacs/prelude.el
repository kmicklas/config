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
