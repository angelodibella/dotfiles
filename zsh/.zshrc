# ============================================================================
# Zsh Configuration - Angelo
# ============================================================================

# ----------------------------------------------------------------------------
# Section 1: Environment Variables & Core Settings
# ----------------------------------------------------------------------------

# Set the default editor
export EDITOR="nvim"

# Generate and export LS_COLORS for colored output in various tools.
# Uses 'dircolors' for robust, standard color definitions.
if command -v dircolors &> /dev/null; then
  export LS_COLORS="$(dircolors -b)"
fi

# --- FZF (Fuzzy Finder) Configuration ---
# Define fzf options using Zsh arrays for correct argument handling.
# These arrays are then expanded into the FZF_DEFAULT_OPTS string.

fzf_default_opts_array=(
  --height 50% --layout=default --border=rounded
  --color='bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8'
  --color='fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc'
  --color='marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8'
  --color='selected-bg:#45475a'
  --color='border:#313244,label:#cdd6f4'
)

# Export FZF_DEFAULT_OPTS for fzf itself and fzf-tab to use.
export FZF_DEFAULT_OPTS="${fzf_default_opts_array[*]}"

# Commands for fzf's standard keybindings (Ctrl+T, Alt+C)
export FZF_CTRL_T_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Preview options for fzf's standard keybindings
export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# --- PATH Configuration ---
# Use `typeset -U path` to ensure unique entries in the PATH.
typeset -U path
path=(
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  "$HOME/.npm/global/bin"
  /usr/local/bin
  /usr/bin
  /bin
  /usr/local/sbin
  /usr/sbin
)
export PATH

# ----------------------------------------------------------------------------
# Section 2: Powerlevel10k Instant Prompt
# (Must be sourced very early for optimal performance)
# ----------------------------------------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ----------------------------------------------------------------------------
# Section 3: Zinit (Plugin Manager) & Plugins
# ----------------------------------------------------------------------------
# Source Zinit itself
source /usr/share/zinit/zinit.zsh

# --- Zinit Plugins ---

# Powerlevel10k Prompt Theme
zinit ice as"theme"
zinit light romkatv/powerlevel10k
# Source personal P10k customizations if the file exists
[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh

# Syntax Highlighting with Catppuccin Theme
# Source the theme file before loading the plugin.
source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh
zinit light zsh-users/zsh-syntax-highlighting

# Core Zsh Enhancement Plugins
# Load order matters: fzf-tab before autosuggestions.
zinit light zsh-users/zsh-completions
zinit light junegunn/fzf-git.sh
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions

# ----------------------------------------------------------------------------
# Section 4: Zsh Shell Behavior
# ----------------------------------------------------------------------------

# --- History Configuration ---
HISTFILE=~/.zsh/.histfile
HISTSIZE=5000
SAVEHIST=5000 # Number of lines to save in the history file
setopt APPEND_HISTORY SHARE_HISTORY HIST_IGNORE_SPACE HIST_SAVE_NO_DUPS HIST_IGNORE_ALL_DUPS HIST_FIND_NO_DUPS

# --- Keybindings ---
bindkey -v  # Use Vim keybindings for command-line editing

# --- Aliases ---
# Source aliases from a separate file for better organization.
[[ -f ~/.zsh/aliases.zsh ]] && source ~/.zsh/aliases.zsh

# ----------------------------------------------------------------------------
# Section 5: Completion System & Styling
# ----------------------------------------------------------------------------

# Initialize Zsh's completion system
autoload -Uz compinit
compinit -d ~/.zsh/.zcompdump # Use a custom dump file location

# Source fzf's own keybindings and completion setup
source <(fzf --zsh)

# --- Zsh Completion System Styling ---
# Use LS_COLORS for completion list colors (fixes '@' for symlinks).
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# Case-insensitive matching for completions.
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# Use a selectable menu for completions.
zstyle ':completion:*' menu select

# --- fzf-tab Configuration ---
# Instruct fzf-tab to use the global FZF_DEFAULT_OPTS for theming.
# This ensures visual consistency with standard fzf keybindings.
zstyle ':fzf-tab:*' use-fzf-default-opts yes

# Configure preview commands for fzf-tab.
# These use the fzf-preview style, which works correctly.
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --tree --color=always $realpath | head -200'
zstyle ':fzf-tab:complete:*:preview' fzf-preview 'bat --color=always -n --line-range :500 $realpath'

# ----------------------------------------------------------------------------
# Section 6: External Tools & Hooks
# ----------------------------------------------------------------------------

# --- Direnv & Zoxide ---
# Initialize direnv for directory-specific environments.
eval "$(direnv hook zsh)"
# Initialize zoxide for fast directory navigation.
eval "$(zoxide init zsh)"

# ============================================================================
# End of Zsh Configuration
# ============================================================================
