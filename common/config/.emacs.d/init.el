;; Author - Suvash Thapaliya
;;
;; This file is generated out of Emacs.org.
;; Edit that file in org-mode to automatically generate this.

(defvar suv/default-fixed-pitch-font "Ubuntu Mono")
(defvar suv/default-fixed-pitch-font-height 160)

(defvar suv/default-variable-pitch-font "Ubuntu")
(defvar suv/default-variable-pitch-font-height 200)

(defvar suv/default-dark-theme 'doom-one)
(defvar suv/default-light-theme 'doom-one-light)

(defvar suv/emacs-custom-file "~/.emacs.d/custom.el")

;; Hide startup screen and message
(setq inhibit-startup-message t
      inhibit-startup-screen t
      initial-scratch-message nil)

;; Turn off UI elements
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(tooltip-mode 0)
(blink-cursor-mode 0)

;; Setup fringe
(set-fringe-mode 10)

;; Set visible bell instead of audio
(setq visible-bell 0)
;; to turn off all indication
(setq ring-bell-function 'ignore)

;; Turn off dialog box
(setq use-dialog-box nil)

;; Change yes-or-no to y-or-n
(defalias 'yes-or-no-p 'y-or-n-p)

;; Turn on line and column numbers
(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Highlight current line
(global-hl-line-mode 1)

;; Turn on electric indent mode (newline and indent)
(electric-indent-mode 1)

;; Display whitespace
(global-whitespace-mode 1)
(setq whitespace-style '(face trailing tabs empty))

;; Use UTF-8 everywhere possible
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(when (display-graphic-p)
   (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))

;; Setup and load separate custom file
(setq custom-file suv/emacs-custom-file)
(load custom-file)

;; Setup repositories
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the repositories
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

;; Initialize use-package and enusure automatic installation of packages
(require 'use-package)
(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package no-littering)

(use-package smooth-scrolling
:init (smooth-scrolling-mode 1))

;; use doom modeline
(use-package doom-modeline
  :init (doom-modeline-mode 1))

;; use a doom theme and flash modeline on bell
(use-package doom-themes
  :config
  (load-theme suv/default-dark-theme t)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

;; Set the font faces
(set-face-attribute 'default nil :font suv/default-fixed-pitch-font :height suv/default-fixed-pitch-font-height)
(set-face-attribute 'fixed-pitch nil :font suv/default-fixed-pitch-font :height suv/default-fixed-pitch-font-height)
(set-face-attribute 'variable-pitch nil :font suv/default-variable-pitch-font :height suv/default-variable-pitch-font-height)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package smartparens
  :init (smartparens-global-mode 1))

(use-package dimmer
  :init (dimmer-mode 1))

(defun suv/linux-only-setup ()
  ;; copy-paste form both clipboards
  (setq x-select-enable-primary t)
  (setq x-select-enable-clipboard t))

(when (string-equal system-type "gnu/linux")
  (suv/linux-only-setup))

(defun suv/copy-from-macos ()
  (shell-command-to-string "pbpaste"))

(defun suv/paste-to-macos (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(defun suv/remap-macos-modifier-keys ()
  ;;(setq mac-function-modifier 'hyper)
  ;;(setq mac-control-modifier 'control)
  ;;(setq mac-command-modifier 'meta)
  ;;(setq mac-option-modifier 'alt)
  ;;(setq mac-right-option-modifier 'super)
  ;;(setq mac-right-command-modifier nil)
  ;;(setq mac-right-control-modifier nil)
  (message "No keys remapped"))

(defun suv/darwin-only-setup ()
  (setq interprogram-cut-function 'suv/paste-to-macos)
  (setq interprogram-paste-function 'suv/copy-from-macos)
  (suv/remap-macos-modifier-keys))

(when (string-equal system-type "darwin")
  (suv/darwin-only-setup))

;; some global keybindings
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-;") 'comment-or-uncomment-region)

;; setup counsel
(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-switch-buffer)
         ("C-x C-f" . counsel-find-file)
         ("C-h v" . counsel-describe-variable)
         ("C-h f" . counsel-describe-function)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil))

;; setup ivy
(use-package ivy
  :after counsel
  :diminish
  :bind (("C-s" . swiper-isearch))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
	ivy-count-format "%d/%d "))

;; setup ivy-rich
(use-package ivy-rich
  :after ivy
  :init (ivy-rich-mode 1))

(use-package which-key
  :init (which-key-mode)
  :diminish
  :config
  (setq which-key-idle-delay 0.1))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; needed for undo/redo properly in evil
(use-package undo-tree
  :init (global-undo-tree-mode))

;; evil config
(use-package evil
  :after undo-tree
  :init
  ;; some evil settings
  (setq evil-move-cursor-back nil)
  (setq evil-emacs-state-cursor '("white" box))
  (setq evil-normal-state-cursor '("green" box))
  (setq evil-insert-state-cursor '("yellow" bar))
  (setq evil-visual-state-cursor '("orange" box))
  (setq evil-replace-state-cursor '("red" box))
  (setq evil-operator-state-cursor '("red" hollow))
  ;; expected by evil-collection
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)
  (evil-set-undo-system 'undo-tree)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal))

;; use evil in more modes
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; general config
(use-package general
  :after evil
  :config
  (general-create-definer suv/define-leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :non-normal-prefix "C-SPC"))

(use-package hydra)

(use-package ivy-hydra)

(defhydra text-scale-hydra (:timeout 4)
  "scale text"
  ("a" text-scale-decrease "smaller")
  ("s" text-scale-increase "larger")
  ("RET" nil "done" :exit t))

(defhydra theme-switch-hydra (:timeout 4)
  "switch light/dark theme"
  ("l" (load-theme suv/default-light-theme t) "Light theme")
  ("d" (load-theme suv/default-dark-theme t) "Dark theme"))

(use-package dumb-jump)

(defhydra dumb-jump-hydra (:color blue :columns 3)
    "Dumb Jump"
    ("g" dumb-jump-go "Go")
    ("o" dumb-jump-go-other-window "Other window")
    ("e" dumb-jump-go-prefer-external "Go external")
    ("x" dumb-jump-go-prefer-external-other-window "Go external other window")
    ("i" dumb-jump-go-prompt "Prompt")
    ("l" dumb-jump-quick-look "Quick look")
    ("b" dumb-jump-back "Back"))

;; use projectile
(use-package projectile
  :diminish projectile-mode
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (projectile-global-mode 1)
  (when (file-directory-p "~/projects")
    (setq projectile-project-search-path '("~/projects"))))

;; use counsel projectile integration
(use-package counsel-projectile
  :config (counsel-projectile-mode))

(suv/define-leader-keys
  "p"  '(:ignore t :which-key "projectile")
  "ps" '(projectile-switch-project :which-key "switch project")
  "pb" '(projectile-switch-to-buffer :which-key "switch buffer")
  "pf" '(projectile-find-file :which-key "find file")
  "pF" '(projectile-find-file-other-window :which-key "find file(other window)")
  "pd" '(projectile-dired :which-key "load dired")
  "pr" '(counsel-projectile-rg :which-key "search(ripgrep)")
  "pk" '(projectile-kill-buffers :which-key "kill buffers"))

(use-package envrc
  :init (envrc-global-mode))

;; use magit
(use-package magit)

(suv/define-leader-keys
  "g"  '(:ignore t :which-key "git (via magit)")
  "gs" '(magit-status :which-key "status"))

(use-package git-gutter
  :init
  (global-git-gutter-mode +1))

;; font setup for org
(defun suv/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font suv/default-variable-pitch-font :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

(defun suv/org-tempo-setup ()
  (require 'org-tempo)
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp")))

(defun suv/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1)
  (suv/org-font-setup)
  (suv/org-tempo-setup))

(use-package org
  :hook (org-mode . suv/org-mode-setup)
  :config
  (setq org-ellipsis " ▾"))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode))

(defun suv/org-mode-visual-fill ()
  (setq visual-fill-column-width 120
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . suv/org-mode-visual-fill))

(org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . t)))

(defun suv/org-babel-tangle-config ()
  (when (string-equal (file-name-nondirectory (buffer-file-name))
                      "Emacs.org")
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'suv/org-babel-tangle-config)))

;; Dired
(use-package dired
  :ensure nil
  :custom ((dired-listing-switches "-agoh --group-directories-first")))

;; DiredFl
(use-package diredfl
  :after dired
  :hook (dired-mode . diredfl-mode))

;; Set executable bit on executable buffers
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; Nix mode
(use-package nix-mode
  :mode "\\.nix\\'"
  :hook (before-save . nix-format-buffer))

;; Elpy
(use-package elpy
  :init
  (elpy-enable))

;; Blacken formatting
(use-package blacken
  :hook (python-mode . blacken-mode))

(suv/define-leader-keys
  "SPC" '(other-window :which-key "other window")
  "." '(dired-jump :which-key "dired jump")
  "b" '(counsel-switch-buffer-other-window :which-key "switch to buffer")
  "k" '(kill-this-buffer :which-key "kill this buffer")
  "w" '(delete-trailing-whitespace :which-key "delete trailing whitespace")
  "t" '(theme-switch-hydra/body :which-key "theme switch")
  "j" '(dumb-jump-hydra/body :which-key "dumb jump")
  "z" '(text-scale-hydra/body :which-key "text scale")
  "0" '(delete-window :which-key "delete window")
  "1" '(delete-other-windows :which-key "delete other windows")
  "2" '(split-window-below :which-key "split window below")
  "3" '(split-window-right :which-key "split window right"))

(message "Ready !")
