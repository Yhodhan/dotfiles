function !!
    # Get the last command from history and execute it
    eval (history --max=1 | head -n 1)
end


