(defun copy-buffer-file-name ()
  "Copy and show the full path to the current file."
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if file-name
      (progn
        (message file-name)
        (kill-new file-name))
      (error "Buffer not visiting a file"))))

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

(general-nmap
  ;; Unmap these so that we can remap in motion state:
  "m" nil
  "o" nil
  "O" nil

  "." 'evil-window-next

  "c" 'evil-substitute
  "C" 'evil-change-whole-line
  "f" 'evil-insert
  "F" 'evil-insert-line
  "i" 'evil-open-below
  "I" 'evil-open-above
  "s" 'evil-change
  "S" 'evil-change-line
  )

(general-mmap
  ";" 'evil-ex

  "e" 'evil-forward-past-word-end
  "E" 'evil-forward-past-WORD-end
  "gd" 'lsp-find-definition
  "gl" 'evil-avy-goto-line
  "o" 'evil-end-of-line
  "O" 'evil-first-non-blank
  "m" 'evil-avy-goto-char
  "M" 'evil-avy-goto-char-2
  (kbd "RET") 'newline-and-indent
  (kbd "<backspace>") 'evil-delete-backward-char
  )

(general-mmap
  :keymaps 'override ;; Needed for motion and other states

  :prefix "SPC"

  "SPC" '(helm-M-x :which-key "execute")

  "b" '(:ignore t :which-key "buffer")
  "bb" '(helm-mini :which-key "switch")
  "bd" '(kill-this-buffer :which-key "delete")

  "c" '(:ignore t :which-key "code")
  "cc" '(comment-line :which-key "comment")
  "cl" 'lsp

  "d" '(dired-jump-other-window :which-key "dired")

  "e" '(:ignore t :which-key "eval")
  "eb" '(eval-buffer :which-key "buffer")
  "ee" '(eval-expression :which-key "expression")
  "er" '(eval-region :which-key "region")

  "f" '(:ignore t :which-key "file")
  "fb" '(magit-blame :which-key "git blame")
  "ff" '(find-file :which-key "find")
  "fr" '(helm-recentf :which-key "recent")
  "fs" '(save-buffer :which-key "save")
  "fy" 'copy-buffer-file-name

  "h" '(:ignore t :which-key "help")
  "hf" 'describe-function
  "hk" 'describe-key
  "hm" 'describe-mode
  "hp" 'describe-package
  "hs" 'describe-symbol
  "hv" 'describe-variable

  "m" '(:ignore t :which-key "mode")

  "g" '(magit-status :which-key "magit")

  "p" '(:ignore t :which-key "project")
  "pa" '(projectile-add-known-project :which-key "add")
  "pd" '(projectile-remove-known-project :which-key "remove")
  "pf" '(helm-projectile-find-file :which-key "find file")
  "pi" '(projectile-invalidate-cache :which-key "invalidate cache")
  "pl" '(projectile-switch-project :which-key "load")
  "pp" '(projectile-persp-switch-project :which-key "perspective")
  "pr" '(projectile-replace :which-key "replace")
  "pR" '(projectile-replace-regexp :which-key "replace regex")
  "ps" '(helm-do-ag-project-root :which-key "search in project")

  "r" '(:ignore t :which-key "replace")
  "rr" '(replace-regexp :which-key "regex")
  "rs" '(replace-string :which-key "string")

  "t"  '(:ignore t :which-key "toggle")
  "tf" '(toggle-frame-fullscreen :which-key "fullscreen")

  "w" '(:ignore t :which-key "window")
  "wd" '(delete-window :which-key "delete")
  "wm" '(popwin:messages :which-key "messages")
  "wr" '(window-swap-states :whick-key "rotate")
  "ws" 'split-window-vertically
  "wv" 'split-window-horizontally
  "ww" '(hydra-window-size/body :which-key "size")
  )

(general-nmap
  :keymaps 'org-mode-map

  "t" 'org-todo
  "H" 'org-promote-subtree
  "L" 'org-demote-subtree
  (kbd "RET") 'org-insert-heading-respect-content
  )
