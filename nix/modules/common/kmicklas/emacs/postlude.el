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
  "." 'evil-window-next

  ;; Unmap these so that we can remap in motion state:
  "a" nil
  "A" nil
  "i" nil

  "f" 'evil-insert
  "F" 'evil-insert-line
  )

(general-mmap
  ";" 'evil-ex

  "a" 'evil-avy-goto-char
  "A" 'evil-avy-goto-char2
  "e" 'evil-forward-past-word-end
  "E" 'evil-forward-past-WORD-end
  "i" 'evil-end-of-line
  "gd" 'lsp-find-definition
  (kbd "RET") 'newline-and-indent
  (kbd "<backspace>") 'delete-backward-char
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
  "pf" '(helm-projectile-find-file :which-key "find file")
  "pi" '(projectile-invalidate-cache :which-key "invalidate cache")
  "pl" '(projectile-switch-project :which-key "load")
  "pp" '(projectile-persp-switch-project :which-key "perspective")
  "pr" '(projectile-replace :which-key "replace")
  "pR" '(projectile-replace-regexp :which-key "replace regex")
  "ps" '(helm-do-ag-project-root :which-key "search in project")

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
