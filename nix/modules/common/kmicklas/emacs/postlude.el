(defun copy-buffer-file-name ()
  "Copy and show the full path to the current file."
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if file-name
      (progn
        (message file-name)
        (kill-new file-name))
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

(defun mark-line ()
  "Mark whole line."
  (interactive)
  (beginning-of-line)
  (push-mark (point))
  (activate-mark)
  (forward-line))

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

(defun insert-project-name-tag ()
  "Insert [PROJECT NAME]."
  (interactive)
  (insert (concat "[" (projectile-project-name) "] ")))

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
  "w" 'undo
  "W" 'undo-tree-visualize
  )

(general-mmap
  ;; Unmap these so that we can remap in normal state:
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
  "gd" 'lsp-find-definition
  "gl" 'evil-avy-goto-line
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

  "a" '(org-agenda :which-key "agenda")

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
  "fc" '(write-file :which-key "copy")
  "fb" '(magit-blame :which-key "git blame")
  "fe" '(revert-buffer :which-key "revert")
  "ff" '(find-file :which-key "find")
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

  "i" '(:ignore t :which-key "insert")
  "ip" 'insert-project-name-tag

  "m" '(:ignore t :which-key "mode")

  "n" '(:ignore t :which-key "narrow")
  "nd" '(narrow-to-defun :which-key "defun")
  "ns" '(org-narrow-to-subtree :which-key "org subtree")
  "nw" 'widen

  "g" '(magit-status :which-key "magit")

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
  "ps" '(helm-do-ag-project-root :which-key "search in project")
  "px" '(projectile-remove-known-project :which-key "remove")

  "r" '(:ignore t :which-key "replace")
  "rr" '(anzu-query-replace-regexp :which-key "regex")
  "rs" '(anzu-query-replace :which-key "string")

  "t"  '(:ignore t :which-key "toggle")
  "tf" '(toggle-frame-fullscreen :which-key "fullscreen")

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
  "C-f" 'evil-search-forward
  "C-s" 'save-buffer
  "C-w" 'kill-this-buffer ;; TODO: Unbind C-w prefix so this works.
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

(add-hook 'modalka-mode-hook (lambda () (when modalka-mode (evil-mode -1))))
(add-hook 'evil-mode-hook (lambda () (when evil-mode (modalka-mode -1))))

(add-hook 'dired-mode-hook #'evil-local-mode)
(add-hook 'magit-mode-hook #'evil-local-mode)
(add-hook 'org-agenda-mode-hook #'evil-local-mode)

(defun kill-insert ()
  "Kill region if active and enter insert mode."
  (interactive)
  (when mark-active (kill-region (point) (mark)))
  (modalka-mode -1))

(defun kill-line-insert ()
  "Kill rest of line and enter insert mode."
  (interactive)
  (kill-line)
  (modalka-mode -1))

(defun kill-line-or-join (&optional arg)
  "Kill rest of line or join next line if at end."
  (interactive)
  (if (eolp) (join-line t) (kill-line arg)))

(defun mark-or-kill-or-kill-whole-line (&optional arg)
  "Kill region if active and non-empty, or set mark. Kill whole line if region is empty."
  (interactive)
  (if mark-active
    (if (eq (point) (mark)) (kill-whole-line) (kill-region (point) (mark)))
    (set-mark-command arg)))

(defun open-below ()
  "Open new line below."
  (interactive)
  (deactivate-mark)
  (end-of-line)
  (newline)
  (indent-for-tab-command)
  (modalka-mode -1))

(defun open-above ()
  "Open new line above."
  (interactive)
  (deactivate-mark)
  (beginning-of-line)
  (newline)
  (forward-line -1)
  (indent-for-tab-command)
  (modalka-mode -1))

(key-seq-define-global "jk" #'modalka-mode)

(general-define-key
  :keymaps 'modalka-mode-map

  "SPC" meta-leader

  "0" 'digit-argument
  "1" 'digit-argument
  "2" 'digit-argument
  "3" 'digit-argument
  "4" 'digit-argument
  "5" 'digit-argument
  "6" 'digit-argument
  "7" 'digit-argument
  "8" 'digit-argument
  "9" 'digit-argument

  "C-r" 'redo
  "w" 'undo
  "W" 'undo-tree-visualize

  "a" 'open-below
  "A" 'open-above
  "s" 'er/expand-region
  "d" 'mark-or-kill-or-kill-whole-line
  "D" 'kill-line-or-join
  "f" 'kill-insert
  "F" 'kill-line-insert

  "v" 'yank
  "c" 'copy-region-as-kill

  "x" ctl-x-map

  "b" 'beginning-or-end-of-buffer

  "j" 'next-line
  "k" 'previous-line

  "J" 'forward-paragraph
  "K" 'backward-paragraph

  "h" 'backward-char
  "l" 'forward-char

  ";" 'alternate-line-boundaries
  ":" 'beginning-of-line-text

  "u" 'backward-word
  "i" 'forward-to-word
  "o" 'forward-word

  "m" 'avy-goto-word-1
  "M" 'avy-goto-char
  "y" 'avy-goto-char-in-line

  "p" 'mark-paragraph
  "," 'mark-line

  "." 'other-window

  "/" 'isearch-forward-regexp
  "?" 'isearch-forward

  "n" 'isearch-repeat-forward
  "N" 'isearch-repeat-backward
  )
