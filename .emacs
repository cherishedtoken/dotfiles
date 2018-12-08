(setq default-directory "/Users/christophergonzalez/")
(setq inhibit-splash-screen t)
(global-set-key [mouse-3] 'mouse-buffer-menu)
(setq-default c-basic-offset 4
              indent-tabs-mode nil)

;; turn on melpa
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))

;; enable visual line mode for a couple of non-programming modes
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
(add-hook 'org-mode-hook 'turn-on-visual-line-mode)

(defun my-inf-ruby-mode-hook ()
  (setq comint-process-echoes t))

(add-hook 'inf-ruby-mode-hook 'my-inf-ruby-mode-hook)

(add-to-list 'load-path "~/lisp/")
(setq inferior-lisp-program "/usr/local/bin/sbcl"
      geiser-racket-binary "/usr/local/bin/racket"
      geiser-repl-use-other-window nil)
(add-hook 'lisp-mode-hook
          (lambda () (slime-mode t)))
(add-hook 'inferior-lisp-mode-hook
          (lambda () (inferior-slime-mode t)))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(defalias 'irb 'inf-ruby)
(defalias 'rr 'run-racket)
(defalias 'rs 'replace-string)
(defalias 'sr 'replace-string) ;; make this typo way too often
(defalias 'sl 'slime)
(defalias 'perl-mode 'cperl-mode)
(defalias 'yes-or-no-p 'y-or-n-p)

(if window-system
    (progn (electric-indent-mode +1)
	   (tool-bar-mode -1)
	   ))
(column-number-mode)
(delete-selection-mode t)
(show-paren-mode t)

(set-face-attribute 'default nil :height 140)
(add-to-list 'default-frame-alist '(foreground-color . "white"))
(add-to-list 'default-frame-alist '(background-color . "black"))
(add-to-list 'default-frame-alist '(width . 90))
(add-to-list 'default-frame-alist '(height . 53))

(set-face-attribute 'mode-line nil
   :foreground "black"
   :background "gold"
   :overline "blue"
   :underline "blue")

(setq redisplay-dont-pause t
      mouse-wheel-follow-mouse 't ; scroll window under mouse
      scroll-step 1) ; keyboard scroll one line at a time

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; Mac commands
(setq mac-command-modifier 'super
      mac-option-modifier 'meta)
(global-set-key (kbd "s-<up>") 'beginning-of-buffer)
(global-set-key (kbd "s-<down>") 'end-of-buffer)
(global-set-key (kbd "s-<left>") 'previous-buffer)
(global-set-key (kbd "s-<right>") 'next-buffer)
(global-set-key (kbd "s-s") 'save-buffer)
(global-set-key (kbd "s-k") 'kill-buffer)
(global-set-key (kbd "s-c") 'kill-ring-save)
(global-set-key (kbd "s-v") 'yank)
(global-set-key (kbd "s-w") 'delete-other-windows)
(global-set-key (kbd "s-z") 'undo)
(global-set-key (kbd "s-q") 'save-buffers-kill-emacs)
(global-set-key (kbd "s-a") 'mark-whole-buffer)
(global-set-key (kbd "s-x") 'kill-region)
(global-set-key (kbd "s-/") 'comment-dwim)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cperl-array-face ((t (:background "black" :foreground "yellow" :weight bold))))
 '(cperl-hash-face ((t (:background "black" :foreground "light green" :slant normal :weight bold))))
 '(cursor ((t (:background "green"))))
 '(font-lock-comment-face ((t (:foreground "red1"))))
 '(font-lock-doc-face ((t (:inherit font-lock-string-face))))
 '(magit-item-highlight ((t nil))))

(defun sudo-edit (&optional arg)
  "Edit currently visited file as root.

  With a prefix ARG prompt for a file to visit.
  Will also prompt for a file to visit if current
  buffer is not visiting a file."
  (interactive "P")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:"
                         (ido-read-file-name "Find file(as root): ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (lsp-java bison-mode inf-ruby typescript-mode slime projectile js2-mode ggtags geiser company-irony-c-headers company-irony)))
 '(send-mail-function (quote sendmail-send-it)))
(put 'set-goal-column 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
