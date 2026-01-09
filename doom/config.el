;;; -*- lexical-binding: t -*-

;; -----------------------------------------------------------------------------------------
;;                              Themes and decoration
;; -----------------------------------------------------------------------------------------

;; prefered color for background is 262f33
(setq doom-theme 'doom-horizon)
(setq doom-font (font-spec :family "Cascadia Mono" :size 22 :weight 'medium))
;;(add-to-list 'default-frame-alist '(undecorated . t))

(setq initial-frame-alist '((fullscreen . maximized)))
(setq default-frame-alist '((fullscreen . maximized)))

;; Hook to remove title bar from new frames created by emacsclient
(add-hook 'after-make-frame-functions
          (lambda (frame)
            (set-frame-parameter frame 'undecorated t)))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(window-divider-mode 0)
(setq-default mode-line-format nil)
(setq lsp-signature-auto-activate nil)
(setq max-mini-window-height 0.2) ;; Set to 20% of the frame height
(setq-default display-line-numbers-width 1) ;; enough for up to 99 lines
(fringe-mode 0)

;; -----------------------------------------------------------------------------------------
;;                              Optimization
;; -----------------------------------------------------------------------------------------
;; native compilation
(setq native-comp-speed 3)
(setq native-comp-jit-compilation t)

;; use fd for file search
(setq projectile-generic-command "fd . --type f --color=never")

;; increase GC threshold during startup
(setq gc-cons-threshold most-positive-fixnum)
;; after Emacs startup, set it to a higher but reasonable value
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 100 1024 1024))))  ;; 100MB
;; Use gcmh for better GC behavior
(use-package! gcmh
  :config
  (gcmh-mode 1))

;; this is for windows, to use eshell more efficiently
;;(add-hook 'eshell-mode-hook (lambda () (company-mode -1)))
;;(setq eshell-cmpl-cycle-completions nil)

(setq company-idle-delay 0.5) ;; Adjust delay to 0.5 seconds (or higher)

;; -----------------------------------------------------------------------------------------
;;                              Windows
;; -----------------------------------------------------------------------------------------
;; enable golden ratio
(require 'zoom)
(custom-set-variables
 '(zoom-size '(0.618 . 0.618)))

(setq zoom-mode t)

(require 'ace-window)
(global-set-key (kbd "M-o") 'ace-window)
(global-set-key (kbd "M-i") '+neotree/find-this-file)
(global-set-key (kbd "M-m") 'neotree-toggle)
(global-set-key (kbd "M-t") '+vterm/toggle)

;; -----------------------------------------------------------------------------------------
;;                          Numbering
;; -----------------------------------------------------------------------------------------

;; Set relative line numbers as default for active windows
(setq display-line-numbers-type 'relative)

;; -----------------------------------------------------------------------------------------
;;                                 ORG Mode
;; -----------------------------------------------------------------------------------------

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; -----------------------------------------------------------------------------------------
;;                               Cursor
;; -----------------------------------------------------------------------------------------
;; Avoids emacs to show the exit prompt
(setq confirm-kill-emacs nil)

;; Avoids evil to go character backward when pressing ESP
(setq evil-move-cursor-back nil)

;; change cursor color and shape
(unless (display-graphic-p)
        (require 'evil-terminal-cursor-changer)
        (evil-terminal-cursor-changer-activate))

(after! treesit
  (setq treesit-font-lock-level 4))

;; (remove-hook 'doom-first-buffer-hook #'global-hl-line-mode)

(custom-set-faces!
  '(hl-line :background "#313a3d"))  ;; replace with your preferred color

(custom-set-faces
 '(font-lock-function-name-face ((t (:foreground "#25B0BC")))))
 ;;'(font-lock-function-name-face ((t (:foreground "#2BBAC5")))))

;; to change cursor color use echo -ne '\033]12;deeppink\007'
(setq evil-normal-state-cursor '(box "#ff033e"))
(setq evil-insert-state-cursor '(bar "#ff033e"))
(setq blink-cursor-mode t)
(setq blink-cursor-interval 0.6)

(defun delete-elements-between-matching-symbols ()
  "Delete all elements between two matching symbols."
  (interactive)
  (save-excursion
    (let ((open-symbol (char-after))
          close-symbol)
      (cond
       ((eq open-symbol ?\() (setq close-symbol ?\)))
       ((eq open-symbol ?\[) (setq close-symbol ?\]))
       ((eq open-symbol ?\{) (setq close-symbol ?\}))
       ((eq open-symbol ?\<) (setq close-symbol ?\>))
       ((eq open-symbol ?\') (setq close-symbol ?\'))
       ((eq open-symbol ?\") (setq close-symbol ?\"))
       (t (error "Cursor is not on an opening symbol")))

      (let ((start (point))
            end)
        (forward-sexp)
        (setq end (1- (point))) ;; Adjust to exclude the closing symbol
        (goto-char start)
        (delete-region (1+ start) end))))) ;; Adjust to exclude the opening symbol

;; copy lines
(defun avy-copy-line-to-point ()
  "Copy a line selected via `avy-goto-line` to the current cursor location without moving."
  (interactive)
  (let ((line-content
         (save-excursion
           (avy-goto-line) ;; jump temporarily
           (buffer-substring (line-beginning-position) (line-end-position)))))
    (save-excursion
      (beginning-of-line)
      (open-line 1)
      (insert line-content))))


;; key-chord configuration inspired by helix
(require 'key-chord)
(key-chord-mode t)

(key-chord-define evil-normal-state-map "gl" 'evil-end-of-line)
(key-chord-define evil-normal-state-map "gh" 'evil-beginning-of-line)

;; buffer control
(key-chord-define evil-normal-state-map "gn" 'next-buffer)
(key-chord-define evil-normal-state-map "gp" 'previous-buffer)
(key-chord-define evil-normal-state-map "ge" 'end-of-buffer)
;(key-chord-define evil-normal-state-map "bk" 'kill-current-buffer)
(key-chord-define evil-normal-state-map "vv" 'basic-save-buffer)
(key-chord-define evil-normal-state-map "ff" 'lsp-format-buffer)

; delete enclosed area
(key-chord-define evil-normal-state-map "md" 'delete-elements-between-matching-symbols)

(key-chord-define evil-normal-state-map "vp" 'split-window-right)
(key-chord-define evil-normal-state-map "sp" 'split-window-below)

(require 'evil-matchit)
(global-evil-matchit-mode t)
(key-chord-define evil-normal-state-map "mm" 'evilmi-jump-items)
;erase all
(key-chord-define evil-normal-state-map "me" 'evilmi-delete-items)

(use-package! avy
  :bind
  (:map isearch-mode-map ("C-j" . avy-isearch)))

;; -----------------------------------------------------------------------------------------
;;                             Development only modes
;; -----------------------------------------------------------------------------------------
 
;; for ladybird development only
(add-to-list 'auto-mode-alist '("\\.ipc\\'" . c++-mode))

(global-set-key (kbd "M-p") 'evil-avy-goto-char)


;; asm 
(add-to-list 'auto-mode-alist '("\\.s\\'" . asm-mode))
(add-to-list 'auto-mode-alist '("\\.asm\\'" . asm-mode))

;; Ensure .c files open in c-mode
(add-to-list 'auto-mode-alist '("\\.c\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c-mode))

;; -----------------------------------------------------------------------------------------
;;                             Multicursors evil-md
;; -----------------------------------------------------------------------------------------
;; Unbind the defaults
(map! :nv "gzj" nil
      :nv "gzk" nil)

(map! :nv "tt" #'avy-copy-line-to-point)

;; Make sure evil is loaded
(with-eval-after-load 'evil
  ;; Bind Ctrl+l in normal state
  (define-key evil-normal-state-map (kbd "C-l") 'evil-delete-back-to-indentation))

;; Convinient remaps
(map! :n "C-o" #'ff-find-other-file)
(map! :nv "C-e" #'move-end-of-line)  ;; bind insert-mode C-e to original

;; Rebind to Alt+b and Alt+u
(map! :nv "M-b" #'evil-mc-make-cursor-move-next-line
;;      :nv "M-u" #'evil-mc-make-cursor-move-prev-line)
      :nv "M-u" #'evil-mc-make-cursor-move-prev-line)

;; -----------------------------------------------------------------------------------------
;;                                LSP
;; -----------------------------------------------------------------------------------------
;; configuration of the lsp
;;(after! lsp-clangd
;;  (setq lsp-clients-clangd-args
;;        '("--clang-tidy"
;;          "--completion-style=bundled"
;;          "--header-insertion=iwyu"
;;          "--header-insertion-decorators"
;;          "--fallback-style=llvm")))

;; -----------------------------------------------------------------------------------------
;;                                Avy
;; -----------------------------------------------------------------------------------------
;;(key-chord-define evil-normal-state-map "cc" 'avy-goto-line)

