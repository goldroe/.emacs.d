;; Custom Emacs configuration
;; Author: Carlos Rivera

;; Custom Lisp Path
(add-to-list 'load-path "~/.emacs.d/lisp/")

(require 'hlsl-mode)
(require 'glsl-mode)
(require 'compile)

(require 'ctags-update)
(ctags-global-auto-update-mode)
(setq ctags-update-prompt-create-tags nil);
;; (autoload 'turn-on-ctags-auto-update-mode "ctags-update" "turn on `ctags-auto-update-mode'." t)
(add-hook 'c-mode-common-hook  'turn-on-ctags-auto-update-mode)
(autoload 'ctags-update "ctags-update" "update TAGS using ctags" t)
(global-set-key "\C-cE" 'ctags-update)
(when (equal system-type 'windows-nt)
  (setq ctags-update-command (expand-file-name  "~/.emacs.d/bin/ctags.exe")))

(defun split-or-unsplit-toggle ()
  "Either splits vertically or unsplits if already split"
  (interactive)
  (if (> (count-windows) 1)
      (delete-other-windows)
    (split-window-right)))

(global-set-key "\ep" 'split-or-unsplit-toggle)
(global-set-key (kbd "C-<return>") 'save-buffer)
(global-set-key (kbd "C-,") 'other-window)
(global-set-key (kbd "<f11>") 'toggle-frame-fullscreen)

(global-set-key "\er" 'query-replace)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(setq compilation-directory-locked nil)
(if (eq system-type 'windows-nt)
    (setq my-buildscript "build.bat"))

(delete-selection-mode 1) ;; Overwrite selected region globally
(global-auto-revert-mode 1) ;; Automatically reloads files edited

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
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)
(setq ido-enable-last-directory-history nil)

(setq-default dabbrev-case-replace t)
(setq-default dabbrev-case-fold-search t)
(setq-default dabbrev-upcase-means-case-search t)

(abbrev-mode 1)

(setq-default frame-title-format "emacs")

;; emacs GUI options
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(if (display-graphic-p)
    (window-divider-mode 1)
  (window-divider-mode -1))

;; Colors and font configuration
(global-font-lock-mode 1)
(if (display-graphic-p)
    (progn
      ;; Windowed mode
      (custom-set-faces
       '(default ((t (:foreground "#d1b897" :background "#051b26" :font "Consolas" :height 140))))
       '(region ((t (:foreground nil :background "midnight blue"))))
       '(cursor ((t (:background "#30ff30"))))
       '(mode-line ((t (:foreground "black" :background "gainsboro" :font "Comic Mono" :height 135))))
       '(minibuffer-prompt ((t (:foreground "cyan" :font "Comic Mono" :height 135))))
       '(fringe ((t (:foreground "cyan" :background "#051b26"))))
       '(linum ((t (:foreground "#051d1e" :background "#051b26"))))
       '(window-divider ((t (:foreground "gainsboro"))))
       '(window-divider-first-pixel ((t (:foreground "gainsboro"))))
       '(window-divider-last-pixel ((t (:foreground "gainsboro"))))

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

  ;; Terminal Mode
  (global-font-lock-mode 0)
  (set-face-background 'vertical-border "white")
  (set-face-foreground 'vertical-border (face-background 'vertical-border)))

;; Accepted file extensions and their appropriate modes
(setq auto-mode-alist
      (append
       '(("\\.cpp$" . c++-mode)
         ("\\.H$"   . c++-mode)
         ("\\.c$"   . c++-mode)
         ("\\.cc$"  . c++-mode)
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
    (c-offsets-alist             . ((arglist-close          .  c-lineup-arglist)
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



(defun my-c-hook()
  (c-add-style "My Style" my-c-style t)

  (setq indent-tabs-mode nil
        truncate-lines nil)

  (font-lock-add-keywords nil
    '(("\\<\\(internal\\|static\\|local_persist\\)\\>" . font-lock-keyword-face)))

  (c-set-offset 'comment-intro 0)
  (c-set-offset 'member-init-intro '++)
  (c-set-offset 'arglist-cont-nonempty '+))
(add-hook 'c-mode-common-hook 'my-c-hook)

(defun my-text-hook ()
  (setq tab-width 4
        indent-tabs-mode nil))
(add-hook 'text-mode-hook 'my-text-hook)

(defun my-elisp-hook ()
  (local-set-key (kbd "\em") 'eval-buffer))
(add-hook 'emacs-lisp-mode-hook 'my-elisp-hook)

;; Maximize screen
(add-hook 'window-setup-hook 'toggle-frame-maximized t)

;; devenv.com error parsing
(add-to-list 'compilation-error-regexp-alist 'casey-devenv)
(add-to-list 'compilation-error-regexp-alist-alist
             '(casey-devenv
               "*\\([0-9]+>\\)?\\(\\(?:[a-zA-Z]:\\)?[^:(\t\n]+\\)(\\([0-9]+\\)) : \\(?:see declaration\\|\\(?:warnin\\(g\\)\\|[a-z ]+\\) C[0-9]+:\\)"
               2 3 nil (4)))

;; Compilation
(setq compilation-context-lines 0)
(setq compilation-error-regexp-alist
    (cons '("^\\([0-9]+>\\)?\\(\\(?:[a-zA-Z]:\\)?[^:(\t\n]+\\)(\\([0-9]+\\)) : \\(?:fatal error\\|warnin\\(g\\)\\) C[0-9]+:" 2 3 nil (4))
     compilation-error-regexp-alist))

(defun find-project-directory-recursive ()
  "Recursively search for a makefile."
  (interactive)
  (if (file-exists-p my-buildscript) t
      (cd "../")
      (find-project-directory-recursive)))

(defun lock-compilation-directory ()
  "The compilation process should NOT hunt for a makefile"
  (interactive)
  (setq compilation-directory-locked t)
  (message "Compilation directory is locked."))

(defun unlock-compilation-directory ()
  "The compilation process SHOULD hunt for a makefile"
  (interactive)
  (setq compilation-directory-locked nil)
  (message "Compilation directory is roaming."))

(defun find-project-directory ()
  "Find the project directory."
  (interactive)
  (setq find-project-from-directory default-directory)
  (switch-to-buffer-other-window "*compilation*")
  (if compilation-directory-locked (cd last-compilation-directory)
  (cd find-project-from-directory)
  (find-project-directory-recursive)
  (setq last-compilation-directory default-directory)))

(defun make-without-asking ()
  "Make the current build."
  (interactive)
  (if (find-project-directory) (compile my-buildscript))
  (other-window 1))
(define-key global-map "\em" 'make-without-asking)

;; Transparency just in case I need to see stuff on the background
;; (set-frame-parameter (selected-frame) 'alpha '(94 50))
;; (add-to-list 'default-frame-alist '(alpha 94 50))

(custom-set-variables
 '(inhibit-startup-screen t)
 '(ring-bell-function 'ignore))
