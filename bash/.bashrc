eval "$(oh-my-posh init bash)"
eval "$(oh-my-posh init bash --config C:/Users/Ad_maiorem/.PoshThemes/slim.omp.json)"
eval "$(zoxide init bash)"

export LS_COLORS="di=0;35:fi=0;36:ln=1;35:ex=1;32"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias rd='rm -rf'
alias ..='cd ..'
alias ga='git add' 
alias gp='git push'
alias gl='git pull'
alias gr='git remote'
alias gm='git merge'
alias gst='git status'
alias gch='git checkout'
alias gcl='git clone'
alias gcm='git commit -m'
alias gpu='git push upstream'
alias grb='git rebase'
alias ggsup='git branch --set-upstream-to=origin/(git_current_branch)'
alias emas='emacsclientw -c -F "((fullscreen ))"'
alias emkill='emacsclientw.exe -e "(kill-emacs)"'

