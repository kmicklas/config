(setq
 inhibit-startup-screen t
 inhibit-startup-message t

 initial-major-mode 'fundamental-mode
 initial-scratch-message nil

 custom-file "~/.emacs.d/custom.el"
 )

(setq-default
 indent-tabs-mode nil
 tab-width 2
 c-basic-offset 2
 show-trailing-whitespace t
 )

(prefer-coding-system 'utf-8)

(add-to-list 'default-frame-alist '(font . "Source Code Pro 8"))

(when (not window-system) (xterm-mouse-mode 1))

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(blink-cursor-mode 0)
(global-display-line-numbers-mode)
(column-number-mode)
(global-hl-line-mode 1)

(defalias 'yes-or-no-p 'y-or-n-p)
