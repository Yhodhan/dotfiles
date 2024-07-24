if status is-interactive
    # Commands to run in interactive sessions can go here
end
zoxide init fish --cmd cd | source
status --is-interactive; and rbenv init - fish | source

source /home/linuxbrew/.linuxbrew/opt/asdf/libexec/asdf.fish
