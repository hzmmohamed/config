if status is-interactive
    # Commands to run in interactive sessions can go here
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/hazem/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

zoxide init fish | source
