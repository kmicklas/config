(defun copy-buffer-file-name ()
  "Copy and show the full path to the current file."
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if file-name
      (progn
        (message file-name)
        (kill-new file-name))
      (error "Buffer not visiting a file"))))

(defhydra hydra-window-size ()
  "window size"
  ("f" enlarge-window-horizontally "enlarge horizontally")
  ("d" shrink-window-horizontally "shrink horizontally")
  ("j" enlarge-window "enlarge vertically")
  ("k" shrink-window "shrink vertically")
  )

(general-nmap
  "." 'evil-window-next
  )

(general-mmap
  ";" 'evil-ex

  "f" 'evil-avy-goto-char
  "F" 'evil-avy-goto-char2
  "gd" 'lsp-find-definition
  (kbd "RET") 'newline-and-indent
  )

(general-mmap
  :keymaps 'override ;; Needed for motion and other states

  :prefix "SPC"

  "SPC" '(helm-M-x :which-key "execute")

  "b" '(:ignore t :which-key "buffer")
  "bb" '(helm-mini :which-key "switch")
  "bd" '(kill-this-buffer :which-key "delete")

  "c" '(:ignore t :which-key "code")
  "cl" '(comment-line :which-key "comment")
  "cs" 'lsp

  "d" '(dired-other-window :which-key "dired")

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
  )
