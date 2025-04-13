
;; If you are distributing this theme, please replace this comment
;; with the appropriate license attributing the original VS Code
;; theme author.

(deftheme cyberpunk "A nice dark theme.")


(let (
(color0 "#262f33")
(color1 "#ffffff")
(color2 "#323242")
(color3 "#262f33")
(color4 "#373747")
(color5 "#2f2f3e")
(color6 "#535368")
(color7 "#434352")
(color8 "#67677c")
(color9 "#9700be")
(color10 "#696979")
(color11 "#06c993")
(color12 "#66667A")
(color13 "#ec89cb")
(color14 "#f60055")
(color15 "#00dded")
(color16 "#3A3A4C")
(color17 "#2d2d3d")
(color18 "#292939"))


(custom-theme-set-faces
'cyberpunk


;; BASIC FACES
`(default ((t (:background ,color0 :foreground ,color1 ))))
`(hl-line ((t (:background ,color2 ))))
`(cursor ((t (:foreground ,color1 ))))
`(region ((t (:background ,color3 ))))
`(secondary-selection ((t (:background ,color4 ))))
`(fringe ((t (:background ,color0 ))))
`(mode-line-inactive ((t (:background ,color5 :foreground ,color6 ))))
`(mode-line ((t (:background ,color7 :foreground ,color8 ))))
`(minibuffer-prompt ((t (:background ,color0 :foreground ,color9 ))))
`(vertical-border ((t (:foreground ,color10 ))))


;; FONT LOCK FACES
`(font-lock-builtin-face ((t (:foreground ,color11 ))))
`(font-lock-comment-face ((t (:foreground ,color12 :fontStyle :italic t ))))
`(font-lock-constant-face ((t (:foreground ,color13 ))))
`(font-lock-function-name-face ((t (:foreground ,color11 ))))
`(font-lock-preprocessor-face ((t (:foreground ,color14 )))) ; #include - red
`(font-lock-keyword-face ((t (:foreground ,color14 ))))
`(font-lock-string-face ((t (:foreground ,color9 ))))
`(font-lock-type-face ((t (:foreground ,color15 ))))
`(font-lock-variable-name-face ((t (:foreground ,color1 ))))


;; linum-mode
`(linum ((t (:foreground ,color16 ))))
`(linum-relative-current-face ((t (:foreground ,color16 ))))


;; display-line-number-mode
`(line-number ((t (:foreground ,color0 ))))
`(line-number-current-line ((t (:foreground ,color0 ))))


`(lsp-face-semhl-namespace ((t (:foreground ,color13)))) ; red
`(lsp-face-semhl-header ((t (:foreground ,color13))))


;; THIRD PARTY PACKAGE FACES


;; doom-modeline-mode
`(doom-modeline-bar ((t (:background ,color7 :foreground ,color8 ))))
`(doom-modeline-inactive-bar ((t (:background ,color5 :foreground ,color6 ))))


;; web-mode
`(web-mode-string-face ((t (:foreground ,color9 ))))
`(web-mode-html-tag-face ((t (:foreground ,color14 ))))
`(web-mode-html-tag-bracket-face ((t (:foreground ,color14 ))))
`(web-mode-html-attr-name-face ((t (:foreground ,color15 ))))


;; company-mode
`(company-tooltip ((t (:background ,color17 :foreground ,color1 ))))


;; org-mode
`(org-block ((t (:background ,color18 :foreground ,color1 ))))
`(org-block-begin-line ((t (:foreground ,color12 ))))))


(custom-theme-set-variables
  'cyberpunk
  '(linum-format " %3i "))


;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))


;;;###autoload
(defun sweetvscode-theme()
  "Apply the sweetvscode-theme."
  (interactive)
  (load-theme 'cyberpunk t))


(provide-theme 'cyberpunk)


;; Local Variables:
;; no-byte-compile: t
;; End:


;; Generated using https://github.com/nice/themeforge
;; Feel free to remove the above URL and this line.
