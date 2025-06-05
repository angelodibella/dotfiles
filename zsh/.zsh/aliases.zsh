# Aliases

# Navigation
alias ls="eza --icons --group-directories-first"
alias ll="eza --icons --group-directories-first -l"
alias la="eza --icons --group-directories-first -a"
alias lla="eza --icons --group-directories-first -la"
alias grep="grep --color"
alias tree="tree -C"

# Python poetry venv activation
alias pyon='eval $(poetry env activate)'  # TODO: Make this more general, especially for uv.
alias pyoff="deactivate"

# Zoxide
alias cd="z"

# Apps
alias chrome="google-chrome-stable"

# Copy-pasting
alias copy="wl-copy"
alias paste="wl-paste"

# Tmux
alias t="tmux"
alias ta="tmux attach -t"
alias tad="tmux attach -d -t"

