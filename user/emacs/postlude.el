(defun zoom-in ()
  "Increase font size by 10 points"
  (interactive)
  (set-face-attribute 'default nil
                      :height
                      (+ (face-attribute 'default :height)
                         10)))

(defun zoom-out ()
  "Decrease font size by 10 points"
  (interactive)
  (set-face-attribute 'default nil
                      :height
                      (- (face-attribute 'default :height)
                         10)))

(defun copy-buffer-file-name ()
  "Copy and show the full path to the current file."
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if file-name
      (progn
        (message file-name)
        (kill-new file-name))
      (error "Buffer not visiting a file"))))

(defun copy-projectile-buffer-file-name ()
  "Copy and show the project-relative path to the current file."
  (interactive)
  (let ((file-name (buffer-file-name))
        (project-root (projectile-project-root)))
    (if (and file-name project-root)
      (let ((relative-path (file-relative-name file-name project-root)))
        (progn
          (message relative-path)
          (kill-new relative-path)))
      (error "Buffer not visiting a file"))))

(defun beginning-or-end-of-buffer ()
  "Go to beginning or end of buffer."
  (interactive)
  (if (bobp) (goto-char (point-max)) (goto-char (point-min))))

(defun alternate-line-boundaries ()
  "Alternate between end, first non-indentation character, and beginning of line."
  (interactive)
  (cond
    ((bolp) (end-of-line))
    ((eolp) (beginning-of-line-text))
    (t (let ((p (point)))
         (beginning-of-line-text)
         (if (eq p (point)) (beginning-of-line) (end-of-line))))))

(defun revert-buffer-preserve-modes ()
  "Revert buffer preserving active modes and without confirmation."
  (interactive)
  (revert-buffer nil t t))

(defun org-insert-heading-above ()
  "Insert heading above current."
  (interactive)
  (beginning-of-line)
  (org-insert-heading))

;; TODO: Make count work on these.
(defun evil-org-open-heading-below ()
  "Open heading below current."
  (interactive)
  (org-insert-heading-respect-content)
  (evil-append-line 1))

(defun evil-org-open-heading-or-line-below ()
  "Open heading line below current, depending on whether currently at a heading."
  (interactive)
  (if (org-at-heading-p)
    (evil-org-open-heading-below)
    (evil-open-below 1)))

(defun evil-org-open-heading-above ()
  "Open heading above current."
  (interactive)
  (org-insert-heading-above)
  (evil-append-line 1))

(defun evil-org-open-heading-or-line-above ()
  "Open heading line above current, depending on whether currently at a heading."
  (interactive)
  (if (org-at-heading-p)
    (evil-org-open-heading-above)
    (evil-open-above 1)))

(evil-define-motion evil-alternate-line-boundaries (count)
  "Alternate between end, first non-indentation character, and beginning of line."
  (alternate-line-boundaries))

(evil-define-motion evil-forward-past-word-end (count &optional bigword)
  "Move the cursor past the end of the COUNT-th next word.
If BIGWORD is non-nil, move by WORDS."
  :type inclusive
  (evil-forward-word-end count bigword)
  ;; HACK: In the operator state we want to behave exactly like
  ;; evil-forward-word-end, because operators operate on the following
  ;; character. Ideally we would somehow make the operators work like
  ;; the movements with inter-character cursors.
  (unless (or (evil-operator-state-p) (eobp)) (forward-char)))

(evil-define-motion evil-forward-past-WORD-end (count)
  "Move the cursor past the end of the COUNT-th next WORD."
  :type inclusive
  (evil-forward-past-word-end count t))

(defhydra hydra-window-size ()
  "window size"
  ("f" enlarge-window-horizontally "enlarge horizontally")
  ("d" shrink-window-horizontally "shrink horizontally")
  ("j" enlarge-window "enlarge vertically")
  ("k" shrink-window "shrink vertically")
  )

(defhydra hydra-brackets ()
  "brackets"
  ("c" sp-wrap-curly "{wrap}")
  ("r" sp-wrap-round "(wrap)")
  ("s" sp-wrap-square "[wrap]")
  ("d" sp-unwrap-sexp "unwrap")
  )

;; For some reason this doesn't work with general-nmap
(define-key evil-normal-state-map "u" nil)

(general-define-key
  :keymaps '(evil-operator-state-map evil-visual-state-map)

  ;; Unmap these so that we can remap in motion state:
  "i" nil
  "I" nil
  "o" nil
  "O" nil
  "u" nil
  "U" nil

  "f" evil-inner-text-objects-map
  )

(general-nmap
  ;; Unmap these so that we can remap in motion state:
  ";" nil
  ":" nil
  "i" nil
  "I" nil
  "m" nil
  "o" nil
  "O" nil
  "u" nil
  "U" nil

  "." 'evil-window-next
  "," 'er/expand-region

  "a" 'evil-open-below
  "A" 'evil-open-above
  "c" 'evil-substitute
  "C" 'evil-change-whole-line
  "e" 'evil-append
  "E" 'evil-append-line
  "f" 'evil-insert
  "F" 'evil-insert-line
  "s" 'evil-change
  "S" 'evil-change-line
  "w" 'evil-undo
  "W" 'undo-tree-visualize
  )

(general-mmap
  ;; Unmap these so that we can remap in normal state:
  "C-b" nil
  "C-f" nil
  "," nil
  "e" nil
  "E" nil
  "w" nil
  "W" nil

  ";" 'evil-alternate-line-boundaries
  ":" 'evil-first-non-blank
  "RET" 'newline-and-indent
  "<backspace>" 'evil-delete-backward-char

  "b" 'beginning-or-end-of-buffer
  "i" 'evil-forward-word-begin
  "I" 'evil-forward-WORD-begin
  "o" 'evil-forward-past-word-end
  "O" 'evil-forward-past-WORD-end
  "m" 'evil-avy-goto-char
  "M" 'evil-avy-goto-char-2
  "u" 'evil-backward-word-begin
  "U" 'evil-backward-WORD-begin
  )

(general-vmap
  "F" 'evil-insert
  )

(general-define-key
  :states '(normal visual motion)
  :keymaps '(override)

  :prefix-command 'meta-leader

  :prefix "SPC"
  :non-normal-prefix "C-SPC"

  "SPC" '(helm-M-x :which-key "execute")
  ";" 'evil-ex
  "/" '(rg-menu :which-key "search")

  "a" '(org-agenda :which-key "agenda")

  "b" '(:ignore t :which-key "buffer")
  "bb" '(helm-mini :which-key "switch")
  "bd" '(kill-this-buffer :which-key "delete")

  "c" '(:ignore t :which-key "code")
  "cc" '(comment-line :which-key "comment")
  "cl" 'lsp
  "cs" '(sort-lines :which-key "sort lines")
  "ct" 'delete-trailing-whitespace

  "d" '(dired-jump-other-window :which-key "dired")

  "e" '(:ignore t :which-key "eval")
  "eb" '(eval-buffer :which-key "buffer")
  "ee" '(eval-expression :which-key "expression")
  "er" '(eval-region :which-key "region")

  "f" '(:ignore t :which-key "file")
  "fc" '(write-file :which-key "copy")
  "fb" '(magit-blame :which-key "git blame")
  "fe" '(revert-buffer-preserve-modes :which-key "revert")
  "ff" '(find-file :which-key "find")
  "fp" 'copy-projectile-buffer-file-name
  "fr" '(helm-recentf :which-key "recent")
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

  "l" '(:keymap lsp-command-map :which-key "language server")

  "p" '(:ignore t :which-key "project")
  "pa" '(projectile-add-known-project :which-key "add")
  "pc" '(projectile-cleanup-known-projects :which-key "clean up known projects")
  "pd" '(projectile-dired :which-key "dired")
  "pf" '(helm-projectile-find-file :which-key "find file")
  "pi" '(projectile-invalidate-cache :which-key "invalidate cache")
  "pl" '(projectile-switch-project :which-key "load")
  "pp" '(projectile-persp-switch-project :which-key "perspective")
  "pr" '(projectile-replace :which-key "replace")
  "pR" '(projectile-replace-regexp :which-key "replace regex")
  "ps" '(helm-projectile-rg :which-key "search in project")
  "px" '(projectile-remove-known-project :which-key "remove")

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
  "qq" '(evil-quit :which-key "window")
  "qa" '(evil-quit-all :which-key "all")
  )

(general-define-key
  "C-b" 'hydra-brackets/body
  "C-f" 'evil-search-forward
  "C-s" 'save-buffer
  "C-w" 'kill-this-buffer ;; TODO: Unbind C-w prefix so this works.

  "C-+" 'zoom-in
  "C-=" 'zoom-in
  "C--" 'zoom-out
  )

(general-nmap
  :keymaps 'org-mode-map

  "<return>" 'org-insert-heading-respect-content
  "<S-return>" 'org-insert-heading-above

  "a" 'evil-org-open-heading-or-line-below
  "A" 'evil-org-open-heading-or-line-above
  "t" 'org-todo
  "H" 'org-promote-subtree
  "L" 'org-demote-subtree
  )

;; evil-org-mode assumes a lot of evil keys that we have remapped.
(general-define-key
  :keymaps 'evil-outer-text-objects-map
  "e" 'evil-org-an-object
  "E" 'evil-org-an-element
  "r" 'evil-org-a-greater-element
  "R" 'evil-org-a-subtree
  )

(general-define-key
  :keymaps 'evil-inner-text-objects-map
  "e" 'evil-org-inner-object
  "E" 'evil-org-inner-element
  "r" 'evil-org-inner-greater-element
  "R" 'evil-org-inner-subtree
  )

;; Work around https://github.com/haskell/haskell-mode/issues/1265
;; Adapted from https://github.com/doomemacs/doomemacs/pull/2351
;; and https://github.com/doomemacs/doomemacs/commit/616956ac948def18d3ae12dad73c5b3623cdf5bd
(defun haskell/evil-open-above ()
  (interactive)
  (evil-beginning-of-line)
  (haskell-indentation-newline-and-indent)
  (evil-previous-line)
  (haskell-indentation-indent-line)
  (evil-append-line nil))

(defun haskell/evil-open-below ()
  (interactive)
  (evil-append-line nil)
  (haskell-indentation-newline-and-indent))

(general-nmap
  :keymaps 'haskell-mode-map
  "a" 'haskell/evil-open-below
  "A" 'haskell/evil-open-above
  )

(add-hook 'dired-mode-hook #'evil-local-mode)
(add-hook 'magit-mode-hook #'evil-local-mode)
(add-hook 'org-agenda-mode-hook #'evil-local-mode)
(add-hook 'evil-normal-state-entry-hook #'company-abort)

(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match
that used by the user's shell.

This is particularly useful under Mac OS X and macOS, where GUI
apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (shell-command-to-string "$SHELL --login -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(set-exec-path-from-shell-PATH)

;; Start server for environments without home-manager user systemd
(unless (server-running-p) (server-start))
