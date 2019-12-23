(setq default-directory "/Users/christophergonzalez/")
(setq inhibit-splash-screen t)
(global-set-key [mouse-3] 'mouse-buffer-menu)
(set-variable 'typescript-indent-level 2)
(setq-default c-basic-offset 4
              indent-tabs-mode nil)
(if window-system
    (progn (electric-indent-mode +1)
	   (tool-bar-mode -1)
           (package-initialize)
	   ))
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

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

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
;; enable typescript-tslint checker

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
;; (add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; (require 'js2-refactor)
;; (require 'xref-js2)

;; (add-hook 'typescript-mode-hook #'js2-refactor-mode)
;; (js2r-add-keybindings-with-prefix "C-c C-r")
;; (define-key js2-mode-map (kbd "C-k") #'js2r-kill)

;; js-mode (which js2 is based on) binds "M-." which conflicts with xref, so
;; unbind it.
;; (define-key js-mode-map (kbd "M-.") nil)

;; (add-hook 'typescript-mode-hook (lambda ()
;;   (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))

(defalias 'irb 'inf-ruby)
(defalias 'rr 'run-racket)
(defalias 'rs 'replace-string)
(defalias 'sr 'replace-string) ;; make this typo way too often
(defalias 'rb 'revert-buffer)
(defalias 'sl 'slime)
(defalias 'perl-mode 'cperl-mode)
(defalias 'yes-or-no-p 'y-or-n-p)

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
    (haskell-mode tide xref-js2 js2-refactor rjsx-mode exec-path-from-shell lsp-java bison-mode inf-ruby typescript-mode slime projectile js2-mode ggtags geiser company-irony-c-headers company-irony)))
 '(send-mail-function (quote sendmail-send-it))
 '(tooltip-hide-delay 10000)
 '(typescript-indent-level 2 t))
(put 'set-goal-column 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(defun query-swap-strings (from-string to-string &optional delimited start end)
  "Swap occurrences of FROM-STRING and TO-STRING."
  (interactive
   (let ((common
          (query-replace-read-args
           (concat "Query swap"
                   (if current-prefix-arg
                       (if (eq current-prefix-arg '-) " backward" " word")
                     "")
                   (if (use-region-p) " in region" ""))
           nil)))
     (list (nth 0 common) (nth 1 common) (nth 2 common)
           (if (use-region-p) (region-beginning))
           (if (use-region-p) (region-end)))))
  (perform-replace
   (concat "\\(" (regexp-quote from-string) "\\)\\|" (regexp-quote to-string))
   `(replace-eval-replacement replace-quote (if (match-string 1) ,to-string ,from-string))
   t t delimited nil nil start end))
