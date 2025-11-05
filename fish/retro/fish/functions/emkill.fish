function emkill --wraps='emacsclientw.exe -e "(kill-emacs)"' --description 'alias emkill=emacsclientw.exe -e "(kill-emacs)"'
  emacsclientw.exe -e "(kill-emacs)" $argv
        
end
