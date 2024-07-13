;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-horizon)

;; enable golden ratio
(require 'zoom)
(setq zoom-mode t)
(custom-set-variables
 '(zoom-size '(0.618 . 0.618)))

;; denable lines truncation
(setq truncate-lines t)

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
(key-chord-mode t)

(key-chord-define evil-normal-state-map "gl" 'evil-end-of-line)
(key-chord-define evil-normal-state-map "gh" 'evil-beginning-of-line)

;; buffer control
(key-chord-define evil-normal-state-map "gn" 'next-buffer)
(key-chord-define evil-normal-state-map "gp" 'previous-buffer)
(key-chord-define evil-normal-state-map "ge" 'end-of-buffer)
(key-chord-define evil-normal-state-map "bk" 'kill-current-buffer);
(key-chord-define evil-normal-state-map "vv" 'basic-save-buffer);

;; change cursor color and shape
(unless (display-graphic-p)
        (require 'evil-terminal-cursor-changer)
        (evil-terminal-cursor-changer-activate))

;; to change cursor color use echo -ne '\033]12;deeppink\007'
(setq evil-normal-state-cursor '(box "deeppink"))
(setq evil-insert-state-cursor '(bar "deeppink"))

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

;; Delete the surrounding symbols of a selected area, much like helix
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

;; replace the surrounding area symbols with others
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

;; matching mode
(key-chord-define evil-visual-state-map "md" 'delete-surrounding-symbols)
(key-chord-define evil-visual-state-map "mr" 'replace-surrounding-symbols)

(require 'evil-matchit)
(key-chord-define evil-normal-state-map "mm" 'evilmi-jump-items)
(key-chord-define evil-normal-state-map "md" 'evilmi-delete-items)
