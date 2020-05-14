(defun copy-buffer-file-name ()
  "Copy and show the full path to the current file."
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if file-name
      (progn
        (message file-name)
        (kill-new file-name))
      (error "Buffer not visiting a file"))))

(general-mmap
  ";" 'evil-ex
  ":" 'evil-repeat-find-char
  )

(general-nmap
  "." 'evil-window-next
  "f" 'evil-avy-goto-char
  "F" 'evil-avy-goto-char2
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

  "d" '(dired-other-window :which-key "dired")

  "f" '(:ignore t :which-key "file")
  "fb" '(magit-blame :which-key "git blame")
  "ff" '(find-file :which-key "find")
  "fr" '(helm-recentf :which-key "recent")
  "fs" '(save-buffer :which-key "save")
  "fy" 'copy-buffer-file-name

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
  "wv" 'split-window-horizontally
  "ws" 'split-window-vertically
  "wd" '(delete-window :which-key "delete")
  )
