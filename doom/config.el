;; -----------------------------------------------------------------------------------------
;;                              Themes and decoration
;; -----------------------------------------------------------------------------------------
(setq doom-theme 'cyberpunk)
(setq doom-font (font-spec :family "Cascadia Mono" :size 22 :weight 'medium))
;;(add-to-list 'default-frame-alist '(undecorated . t))

(setq initial-frame-alist '((fullscreen . maximized)))
(setq default-frame-alist '((fullscreen . maximized)))

;; Hook to remove title bar from new frames created by emacsclient
(add-hook 'after-make-frame-functions
          (lambda (frame)
            (set-frame-parameter frame 'undecorated t)))
(scroll-bar-mode -1)
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

;; -----------------------------------------------------------------------------------------
;;                              Windows
;; -----------------------------------------------------------------------------------------
;; enable golden ratio
(require 'zoom)
(custom-set-variables
 '(zoom-size '(0.618 . 0.618)))

(require 'ace-window)
(global-set-key (kbd "M-o") 'ace-window)

;; -----------------------------------------------------------------------------------------
;;                          Numbering
;; -----------------------------------------------------------------------------------------

;; Set relative line numbers as default for active windows
(setq display-line-numbers-type 'nil)

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

(remove-hook 'doom-first-buffer-hook #'global-hl-line-mode)

;; to change cursor color use echo -ne '\033]12;deeppink\007'
;;(setq evil-normal-state-cursor '(box "deeppink"))
;;(setq evil-insert-state-cursor '(bar "deeppink"))
(blink-cursor-mode t)
(setq blink-cursor-interval 0.6)

;; Add multiple cursors
(require 'multiple-cursors)
;; multiple-cursors packages uses vanilla emacs keybindins to move arround
;; but this overrides are more convinient to swap modes and spawn the cursors
(global-set-key (kbd "M-c") 'set-rectangular-region-anchor)
(global-set-key (kbd "M-n") 'evil-normal-state)
(global-set-key (kbd "M-a") 'mc/mark-all-dwim)
(global-set-key (kbd "M-.") 'mc/mark-all-like-this)
;; NOTES on basic vanilla emacs movement
;; C-f move forward  | C-b move backward
;; C-n next line     | C-p previous line
;; C-a start of line | C-e end of line
;; C-/ undo          | C-j create new line
;; C-x 0 delete window | C-x 1 delete other windows
;; C-x 2 spawn horizontal | C-x 3 spawn vertical

;; -----------------------------------------------------------------------------------------
;;                            Comments behavior
;; -----------------------------------------------------------------------------------------


(defface custom-comment-face
  '((t :foreground "#444444"   ;; Set your custom foreground color (text color)
       :background "#a3a3a3"   ;; Set your custom background color
       ))
  "Face for highlighting comments after // or /*."
  :group 'custom-faces)

(defun highlight-comments ()
  "Highlight everything after // or /* in comments with a custom face."
  (font-lock-add-keywords nil
   '(("//.*" 0 'custom-comment-face t)          ;; Single-line comments after //
     ("#.*" 0 'custom-comment-face t)
     ("/\\*\\(.\\|\n\\)*?\\*/" 0 'custom-comment-face t))) ;; Multi-line comments /* ... */
  (font-lock-flush))
;; Hook the function to C/C++ modes, or any other mode where you want it:
;;(add-hook 'c-mode-hook 'my-highlight-custom-comments)
;;(add-hook 'c++-mode-hook 'my-highlight-custom-comments)

(add-hook 'prog-mode-hook 'highlight-comments)

;; =========================
;;   HELIX EMULATION LAYER
;; =========================

;; Delete the surrounding symbols of a selected area.
(defun delete-surrounding-symbols (start end)
  "Delete surrounding symbols of a selected region in visual mode."
  (interactive "r")
  (save-excursion
    ;; Move to end and check the character after the region
    (goto-char end)
    (let ((end-symbol (char-after)))
      (when (member end-symbol '(?\) ?\] ?\} ?\" ?\' ?\`))
        (delete-char 1)))
    ;; Move to start and check the character before the region
    (goto-char start)
    (let ((start-symbol (char-before)))
      (when (member start-symbol '(?\( ?\[ ?\{ ?\" ?\' ?\`))
        (delete-char -1)))))

;; replace the surrounding area symbols with others.
(defun replace-surrounding-symbols (start end symbol)
  "Replace surrounding symbols of a selected region with matching symbols."
  (interactive "r\ncEnter opening symbol: ")
  (let ((open-symbol symbol)
        (close-symbol (pcase symbol
                        (?\( ?\))
                        (?\[ ?\])
                        (?\{ ?\})
                        (?\" ?\")
                        (?\' ?\')
                        (?` ?`))))
    (save-excursion
      ;; Replace end symbol
      (goto-char end)
      (let ((end-symbol (char-after)))
        (when (member end-symbol '(?\) ?\] ?\} ?\" ?\' ?\`))
          (delete-char 1)
          (insert close-symbol)))
      ;; Replace start symbol
      (goto-char start)
      (let ((start-symbol (char-before)))
        (when (member start-symbol '(?\( ?\[ ?\{ ?\" ?\' ?\`))
          (delete-char -1)
          (insert open-symbol))))))

(defun add-symbols-around-region (start end open-symbol)
  "Add symbols around the selected region."
  (interactive "r\nMEnter opening symbol: ")
  (let* ((close-symbol (cond
                        ((string= open-symbol "(") ")")
                        ((string= open-symbol "[") "]")
                        ((string= open-symbol "{") "}")
                        (t (error "No matching closing symbol found")))))
    (save-excursion
      (goto-char end)
      (insert close-symbol)
      (goto-char start)
      (insert open-symbol))))

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


;; key-chord configuration inspired by helix
(require 'key-chord)
(key-chord-mode t)

(key-chord-define evil-normal-state-map "gl" 'evil-end-of-line)
(key-chord-define evil-normal-state-map "gh" 'evil-beginning-of-line)

;; buffer control
(key-chord-define evil-normal-state-map "gn" 'next-buffer)
(key-chord-define evil-normal-state-map "gp" 'previous-buffer)
(key-chord-define evil-normal-state-map "ge" 'end-of-buffer)
(key-chord-define evil-normal-state-map "bk" 'kill-current-buffer)
(key-chord-define evil-normal-state-map "vv" 'basic-save-buffer)
(key-chord-define evil-normal-state-map "ff" 'lsp-format-buffer)

(key-chord-define evil-visual-state-map "ma" 'add-symbols-around-region)
(key-chord-define evil-visual-state-map "md" 'delete-surrounding-symbols)
(key-chord-define evil-visual-state-map "mr" 'replace-surrounding-symbols)
; delete enclosed area
(key-chord-define evil-normal-state-map "md" 'delete-elements-between-matching-symbols)

(require 'evil-matchit)
(global-evil-matchit-mode t)
(key-chord-define evil-normal-state-map "mm" 'evilmi-jump-items)
;erase all
(key-chord-define evil-normal-state-map "me" 'evilmi-delete-items)

;; -----------------------------------------------------------------------------------------
;;                                LSP
;; -----------------------------------------------------------------------------------------
;; configuration of the lsp
(after! lsp-clangd
  (setq lsp-clients-clangd-args
        '("--clang-tidy"
          "--completion-style=bundled"
          "--header-insertion=iwyu"
          "--header-insertion-decorators"
          "--fallback-style=gnu")))

;; -----------------------------------------------------------------------------------------
;;                                Avy
;; -----------------------------------------------------------------------------------------
(use-package! avy
  :bind
  (:map isearch-mode-map ("C-j" . avy-isearch)))

(global-set-key (kbd "M-p") 'evil-avy-goto-char)
(key-chord-define evil-normal-state-map "cc" 'avy-goto-line)
