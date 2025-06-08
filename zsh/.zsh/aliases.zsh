# Aliases

# Navigation
alias ls="eza --icons --group-directories-first"
alias ll="eza --icons --group-directories-first -l"
alias la="eza --icons --group-directories-first -a"
alias lla="eza --icons --group-directories-first -la"
alias grep="grep --color"
alias tree="tree -C"

# Python poetry venv activation
uv-activate() {
  # Start search from the current directory
  local search_path
  if ! search_path=$(pwd); then
    echo "Error: Could not determine current directory." >&2
    return 1
  fi

  # Loop upwards until we find the activation script or hit the filesystem root
  while [[ "$search_path" != "/" && ! -f "$search_path/.venv/bin/activate" ]]; do
    search_path=${search_path:h}
  done

  # After the loop, perform one final check in case the .venv is in the root (e.g., /)
  local venv_activate_script="$search_path/.venv/bin/activate"

  if [[ -f "$venv_activate_script" ]]; then
    source "$venv_activate_script"
  else
    echo "No .venv found in the current directory or any parent." >&2
    return 1
  fi
}

alias pyon='uv-activate'
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

