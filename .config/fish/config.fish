if status is-interactive
    # Commands to run in interactive sessions can go here
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/hazem/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

zoxide init fish | source

set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket


export GPG_TTY=$(tty)  # https://gist.github.com/paolocarrasco/18ca8fe6e63490ae1be23e84a7039374?permalink_comment_id=3767413
set nvm_default_version lts
