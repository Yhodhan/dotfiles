;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-horizon)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Avoids emacs to show the exit prompt
(setq confirm-kill-emacs nil)

;; Avoids evil to go character backward when pressing ESP
(setq evil-move-cursor-back nil)

;; key-chord configuration inspired by helix
(require 'key-chord)
(key-chord-mode 1)

(key-chord-define evil-normal-state-map "gl" 'evil-end-of-line)
(key-chord-define evil-normal-state-map "gh" 'evil-beginning-of-line)
;; buffer control
(key-chord-define evil-normal-state-map "gn" 'next-buffer)
(key-chord-define evil-normal-state-map "gp" 'previous-buffer)
(key-chord-define evil-normal-state-map "ge" 'end-of-buffer)
(key-chord-define evil-normal-state-map "bk" 'kill-current-buffer);

;; matching mode
(require 'evil-matchit)
(key-chord-define evil-normal-state-map "mm" 'evilmi-jump-items)
(key-chord-define evil-visual-state-map "mm" 'evilmi-jump-items)

;; change cursor color and shape
(unless (display-graphic-p)
        (require 'evil-terminal-cursor-changer)
        (evil-terminal-cursor-changer-activate))

;; to change cursor color use echo -ne '\033]12;deeppink\007'
(setq evil-normal-state-cursor 'box)
(setq evil-insert-state-cursor 'bar)

(require 'evil-snipe)

(evil-snipe-mode +1)
;; deactivate snipe in magit
(defun turn-off-evil-snipe()
  (evil-snipe-mode nil))
(add-hook 'magit-mode-hook 'turn-off-evil-snipe)

;; Add multiple cursors
(require 'multiple-cursors)
;; multiple-cursors packages uses vanilla emacs keybindins to move arround
;; but this overrides are more convinient
(global-set-key (kbd "M-c") 'mc/mark-next-lines)
(global-set-key (kbd "M-a") 'mc/mark-all-like-this)
(global-set-key (kbd "M-d") 'mc/mark-all-dwim)
(global-set-key (kbd "C-,") 'mc/edit-lines)
;; Notes on basic vanilla emacs movement
;; C-f move forward  | C-b move backward
;; C-n next line     | C-p previous line
;; C-a start of line | C-e end of line
;; C-/ undo          | C-j create new line
