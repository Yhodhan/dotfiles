if status is-interactive
    # Commands to run in interactive sessions can go here
    set -U fish_color_command red
    set -U fish_color_parameter magenta 
    set -U fish_color_quote magenta
end
zoxide init fish --cmd cd | source
