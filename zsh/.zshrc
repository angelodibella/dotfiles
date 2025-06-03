# ============================================================================
#                                                                            #
#                              ANGELO'S ZSHRC                                #
#                                                                            #
# ============================================================================
#
# Sections:
#   1. Environment Variables & PATH
#   2. Powerlevel10k Instant Prompt
#   3. Zinit (Plugin Manager)
#   4. Zsh Options, History, and Keybindings
#   5. Completion System & Styling
#   6. External Tools & Hooks
#

# ============================================================================
# 1. ENVIRONMENT VARIABLES & PATH
# ============================================================================

# Set the default editor for the system
export EDITOR="nvim"

# Generate a comprehensive LS_COLORS map from 'dircolors' to enable colored
# completions and fix display artifacts (e.g., the '@' symbol for symlinks).
if command -v dircolors &> /dev/null; then
  export LS_COLORS="$(dircolors -b)"
fi

# --- FZF Configuration ---
# Options are defined in Zsh arrays to correctly handle spaces and arguments.
# This is the modern, correct way to configure fzf in Zsh.

# Base theme and layout options
fzf_default_opts_array=(
  --height 50% --layout=default --border=rounded
  --color='bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8'
  --color='fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc'
  --color='marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8'
  --color='selected-bg:#45475a'
  --color='border:#313244,label:#cdd6f4'
)

# For compatibility with fzf's internal keybinding scripts (which expect
# exported strings), we export the array contents as a single string.
export FZF_DEFAULT_OPTS="${fzf_default_opts_array[*]}"
export FZF_CTRL_T_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# --- PATH Configuration ---
# Use `typeset -U path` to ensure the PATH array contains only unique entries.
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


# ============================================================================
# 2. POWERLEVEL10K INSTANT PROMPT
#    (Must be sourced near the top of the file)
# ============================================================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# ============================================================================
# 3. ZINIT (PLUGIN MANAGER)
# ============================================================================
source /usr/share/zinit/zinit.zsh

## Prompt Theme
zinit ice as"theme"
zinit light romkatv/powerlevel10k
# Source personal P10k customizations if the file exists
[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh

## Syntax Highlighting
# The theme file must be sourced before the plugin is loaded.
source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh
zinit light zsh-users/zsh-syntax-highlighting

## Core Functionality & Completions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light junegunn/fzf-git.sh
zinit light Aloxaf/fzf-tab


# ============================================================================
# 4. ZSH OPTIONS, HISTORY, AND KEYBINDINGS
# ============================================================================

## History Configuration
HISTFILE=~/.zsh/.histfile
HISTSIZE=5000
SAVEHIST=5000
setopt APPEND_HISTORY SHARE_HISTORY HIST_IGNORE_SPACE HIST_SAVE_NO_DUPS HIST_IGNORE_ALL_DUPS HIST_FIND_NO_DUPS

## Keybindings
bindkey -v  # Use Vim keybindings in command-line mode

## Aliases
# Source a separate file for aliases to keep this file clean.
[[ -f ~/.zsh/aliases.zsh ]] && source ~/.zsh/aliases.zsh


# ============================================================================
# 5. COMPLETION SYSTEM & STYLING
# ============================================================================
autoload -Uz compinit
compinit -d ~/.zsh/.zcompdump

# Source fzf's keybindings
source <(fzf --zsh)

## Zsh Completion System Styling
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select

## fzf-tab Preview Configuration
# ANNOTATION: Theming `fzf-tab` via `fzf-opts` is currently not working due to a
# suspected incompatibility. However, setting previews works correctly.
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --tree --color=always $realpath | head -200'
zstyle ':fzf-tab:complete:*:preview' fzf-preview 'bat --color=always -n --line-range :500 $realpath'


# ============================================================================
# 6. EXTERNAL TOOLS & HOOKS
# ============================================================================

## SSH Agent (start only if not already running)
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-info
fi
if [[ -f ~/.ssh-agent-info ]]; then
    source ~/.ssh-agent-info > /dev/null
fi

## Direnv & Zoxide
eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"

# ============================================================================
#                                END OF FILE                                 #
# ============================================================================
