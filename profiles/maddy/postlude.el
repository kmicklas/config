;; Font tools
;;
(defun my/zoom-in ()
  "Increase font size by 10 points"
  (interactive)
  (set-face-attribute 'default nil
                      :height
                      (+ (face-attribute 'default :height)
                         10)))

(defun my/zoom-out ()
  "Decrease font size by 10 points"
  (interactive)
  (set-face-attribute 'default nil
                      :height
                      (- (face-attribute 'default :height)
                         10)))

;; change font size, interactively
(global-set-key (kbd "C->") 'my/zoom-in)
(global-set-key (kbd "C-<") 'my/zoom-out)

;; Clean white spaces
;;
(defun clean-buffer ()
  "Remove white space at the end of lines and extra new lines at the end."
  (interactive "*")
  (save-excursion
    (goto-char (point-max))
    (delete-horizontal-space)
    (while (re-search-backward "[ \t]\n" (point-min) t)
      (delete-horizontal-space))
    (goto-char (point-max))
    (if (re-search-backward "[^\n]" (point-min) t)
        (progn
          (forward-char 1)
          (replace-regexp "\n*" "\n")))))

(global-set-key "\C-xw"         'clean-buffer)
(global-set-key "\M-k"          'copy-line)

;; Spell checking
;;
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

(global-set-key "\C-xp"    'ispell-buffer)
(global-set-key "\C-x["    'flyspell-check-previous-highlighted-word)
(global-set-key "\C-x]"    'ispell-region)

;; Code
(global-set-key "\C-x,"    'flycheck-previous-error)
(global-set-key "\C-x."    'flycheck-next-error)

;; use count-words instead of count-words-region as it works on buffer
;; if no region is selected
(global-set-key (kbd "M-=") 'count-words)

;; org mode settings
;;
(defun set-org-keys ()
  (local-set-key (kbd "\C-z <up>") #'outline-up-heading)
  (local-set-key (kbd "\C-z <right>") #'org-forward-heading-same-level)
  (local-set-key (kbd "\C-z <left>") #'org-backward-heading-same-level))

(setq org-startup-truncated nil)
(with-eval-after-load 'org
  (setq org-startup-indented t) ; Enable `org-indent-mode' by default
  (add-hook 'org-mode-hook #'visual-line-mode)
  (add-hook 'org-mode-hook #'variable-pitch-mode)  ; TODO: set this for the story dir
  (set-face-attribute 'org-table nil :inherit 'fixed-pitch))
