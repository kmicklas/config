(setq
 inhibit-startup-screen t
 inhibit-startup-message t

 initial-major-mode 'fundamental-mode
 initial-scratch-message nil
 )

(when window-system
  (set-frame-font "Source Code Pro 10"))

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(blink-cursor-mode 0)
