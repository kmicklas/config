(setq
  inhibit-startup-screen t
  inhibit-startup-message t
  initial-scratch-message nil

  make-backup-files nil
  auto-save-default nil
  undo-tree-auto-save-history nil

  vc-handled-backends '()

  custom-file "~/.config/emacs/custom.el"
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

(use-package doom-modeline
  :init (doom-modeline-mode 1)
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

(use-package lsp-mode)

(defun fuzzy-find-file ()
  "Run consult-fd starting from command-line-default-directory."
  (interactive)
  (consult-fd command-line-default-directory)
)

(global-unset-key (kbd ","))

(general-define-key
  :prefix ","

  "SPC" '((lambda () (interactive) (insert ", ")) :which-key ", ")
  "," '(self-insert-command :which-key ",")
  "." 'other-window

  "a" '(org-agenda :which-key "agenda")

  "b" '(:ignore t :which-key "buffer")
  "bb" '(consult-buffer :which-key "switch")
  "bd" '(kill-this-buffer :which-key "delete")

  "c" '(:ignore t :which-key "code")
  "cc" '(comment-line :which-key "comment")
  "cl" 'lsp
  "cs" '(sort-lines :which-key "sort lines")
  "ct" 'delete-trailing-whitespace

  "d" '(dired-jump-other-window :which-key "dired other window")
  "D" '(dired-jump :which-key "dired")

  "e" '(:ignore t :which-key "eval")
  "eb" '(eval-buffer :which-key "buffer")
  "ee" '(eval-expression :which-key "expression")
  "er" '(eval-region :which-key "region")

  "f" '(:ignore t :which-key "file")
  "fc" '(write-file :which-key "copy")
  "fb" '(magit-blame :which-key "git blame")
  "fe" '(revert-buffer-preserve-modes :which-key "revert")
  "ff" '(fuzzy-find-file :which-key "find")
  "fs" '(save-buffer :which-key "save")
  "fy" 'copy-buffer-file-name

  "h" '(:ignore t :which-key "help")
  "hc" 'describe-char
  "hf" 'describe-function
  "hF" 'describe-face
  "hk" 'describe-key
  "hK" '(which-key-show-top-level :which-key "top level keys")
  "hm" 'describe-mode
  "hM" '(which-key-show-keymap :which-key "keymap")
  "hp" 'describe-package
  "hs" 'describe-symbol
  "hv" 'describe-variable
  "hy" '(yas-describe-tables :which-key "yasnippets")

  "j" '(:ignore t :which-key "jump")
  "jd" '(lsp-find-definition :which-key "definition")
  "je" '(flycheck-next-error :which-key "error")
  "jE" '(flycheck-previous-error :which-key "error")
  "jf" '(beginning-of-defun :whick-key "function start")
  "jF" '(end-of-defun :whick-key "function end")
  "jl" '(evil-avy-goto-line :which-key "line")
  "jr" '(lsp-find-references :which-key "references")
  "jt" '(lsp-find-type-definition :which-key "type")

  "i" '(:ignore t :which-key "insert")
  "iu" 'uuidgen

  "m" '(:ignore t :which-key "mode")

  "n" '(:ignore t :which-key "narrow")
  "nd" '(narrow-to-defun :which-key "defun")
  "ns" '(org-narrow-to-subtree :which-key "org subtree")
  "nw" 'widen

  "g" '(magit-status :which-key "magit")

  "l" '(:keymap lsp-command-map :package lsp-mode :which-key "language server")

  "r" '(:ignore t :which-key "replace")
  "rr" '(anzu-query-replace-regexp :which-key "regex")
  "rs" '(anzu-query-replace :which-key "string")

  "s" 'vterm-other-window
  "S" 'vterm

  "t"  '(:ignore t :which-key "toggle")
  "tf" '(toggle-frame-fullscreen :which-key "fullscreen")
  "ts" '(smartparens-mode :which-key "smartparens")

  "v" '(:ignore t :which-key "view")
  "vv" '(persp-switch :which-key "switch")
  "vx" '(persp-kill :which-key "remove")

  "w" '(:ignore t :which-key "window")
  "wd" '(delete-window :which-key "delete")
  "wm" '(popwin:messages :which-key "messages")
  "wr" '(window-swap-states :whick-key "rotate")
  "ws" 'split-window-vertically
  "wv" 'split-window-horizontally
  "ww" '(hydra-window-size/body :which-key "size")

  "q" '(:ignore t :which-key "quit")
  "qq" '(save-buffers-kill-terminal :which-key "window")
)

(general-define-key
  "C-a" 'mark-whole-buffer
  "C-f" 'isearch-forward
  "C-s" 'save-buffer
  "C-z" 'undo
)
