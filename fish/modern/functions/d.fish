function d --wraps=emacs --wraps=emacsclient\ -c\ -a\ \'emacs\' --description alias\ d=emacsclient\ -c\ -a\ \'emacs\'
  emacsclient -c -a 'emacs' $argv
        
end
