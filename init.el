;; Custom Emacs init file
;; Author: Carlos Rivera

;; Custom Lisp Path
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; Go-Mode Plugin
(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

;; Xah-Fly-Keys Plugin
(require 'xah-fly-keys)
(xah-fly-keys-set-layout "qwerty")
;; (define-key key-translation-map (kbd "ESC") (kbd "C-g"))
;; (global-set-key (kbd "`") 'xah-fly-command-mode-activate)
(xah-fly-keys 1 )

;; Default variables
(setq-default tab-width 4)

;; Overwrite selected region globally
(delete-selection-mode 1)

;; Automatically reloads files edited
;; outside of emacs (for all buffers)
(global-auto-revert-mode 1)

;; Stop Emacs from losing undo information by
;; setting very high limits for undo buffers
(setq undo-limit 20000000)
(setq undo-strong-limit 40000000)

;; Sets backup directory and turns auto-save off
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))
(setq auto-save-default nil)

;; ido-mode configuration for opening files/buffers
(require 'ido)
(setq ido-enable-tramp-completeion nil)
(ido-mode 1)
(setq  ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)
(setq ido-enable-last-directory-history nil)

;; Turn off emacs GUI options
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)

;; Colors and font configuration
(if (display-graphic-p)
    ;; Window GUI mode
    (progn
      (global-font-lock-mode 1)
      (custom-set-faces
	'(default ((t (:foreground "#d1b897" :background "#051b26" :font "Consolas" :height 140))))
	'(region ((t (:foreground nil :background "midnight blue"))))
	'(cursor ((t (:background "#30ff30"))))
	'(mode-line ((t (:inverse-video t))))
	'(fringe ((t (:foreground "cyan" :background "#051b26"))))
	'(linum ((t (:foreground "#051d1e" :background "#051b26"))))
	
	'(font-lock-builtin-face ((t nil)))
	'(font-lock-comment-face ((t (:foreground "green1"))))
	'(font-lock-comment-delimiter-face ((t (:foreground "green1"))))
	'(font-lock-constant-face ((t (:foreground "white"))))
	'(font-lock-doc-face ((t (:foreground "green3"))))
	'(font-lock-function-name-face ((t (:foreground "white"))))
	'(font-lock-keyword-face ((t (:foreground "white"))))
	'(font-lock-preprocessor-face ((t (:foreground "white"))))
	'(font-lock-string-face ((t (:foreground "green4"))))
	'(font-lock-type-face ((t (:foreground "#8cde94"))))
	'(font-lock-variable-name-face ((t (:foreground "#c1d1e3"))))

	'(widget-field-face ((t (:foreground "white"))) t)
	'(widget-single-line-field-face ((t (:background "darkgray"))) t)))

  ;; Terminal mode
  (progn
    (global-font-lock-mode 0)
    (custom-set-faces
     '(default ((t (:foreground "white" :background "black"))))
     '(mode-line ((t (:inverse-video t)))))))

;; Accepted file extensions and their appropriate modes
(setq auto-mode-alist
      (append
       '(("\\.cpp$"    . c++-mode)
         ("\\.h$"    . c++-mode)
         ("\\.c$"   . c++-mode)
         ("\\.txt$" . indented-text-mode)
	 ) auto-mode-alist))

;; Custom C/C++ Style
(defconst my-c-style
  '((c-electric-pound-behavior   . nil)
    (c-tab-always-indent         . t)
    (c-comment-only-line-offset  . 4)
    (c-hanging-braces-alist      . ((class-open)
                                    (class-close)
                                    (defun-open)
                                    (defun-close)
                                    (inline-open)
                                    (inline-close)
                                    (brace-list-open)
                                    (brace-list-close)
                                    (brace-list-intro)
                                    (brace-list-entry)
                                    (block-open)
                                    (block-close)
                                    (substatement-open)
                                    (statement-case-open)
                                    (class-open)))
    (c-hanging-colons-alist      . ((inher-intro)
                                    (case-label)
                                    (label)
                                    (access-label)
                                    (access-key)
                                    (member-init-intro)))
    (c-cleanup-list              . (scope-operator
                                    list-close-comma
                                    defun-close-semi))
    (c-offsets-alist             . ((arglist-close         .  c-lineup-arglist)
                                    (label                 . -4)
                                    (access-label          . -4)
                                    (substatement-open     .  0)
                                    (statement-case-intro  .  4)
                                    (statement-block-intro .  4)
                                    (case-label            .  4)
                                    (block-open            .  0)
                                    (inline-open           .  0)
				    (topmost-intro         .  0)
                                    (topmost-intro-cont    .  0)
				    (defun-block-intro     .  4)
                                    (knr-argdecl-intro     .  0)
                                    (brace-list-open       .  0)
                                    (brace-list-intro      .  4)))
    (c-echo-syntactic-information-p . t))
  "My C Style")

(defun my-go-hook()
  (setq tab-width 4
	indent-tabs-mode t
	truncate-lines nil))

(add-hook 'go-mode-hook 'my-go-hook)

(defun my-c-hook()
  (c-add-style "My Style" my-c-style t)
 
  (setq tab-width 4
        indent-tabs-mode nil
        truncate-lines nil)
  
  (c-set-offset 'comment-intro 0)
  (c-set-offset 'member-init-intro '++))

(add-hook 'c-mode-common-hook 'my-c-hook)

;; (define-key global-map "\e/" 'dabbrev-expand)

;; Maximize screen
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(ring-bell-function 'ignore))
