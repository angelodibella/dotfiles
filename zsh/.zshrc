# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ -f ~/.zsh/aliases.zsh ]] && source ~/.zsh/aliases.zsh

# Key bindings
bindkey "^[[1;5C"   forward-word
bindkey "^[[1;5D"   backward-word
bindkey "^H"        backward-kill-word
bindkey  "^[[H"     beginning-of-line
bindkey  "^[[F"     end-of-line
bindkey  "^[[3~"    delete-char

HISTFILE=~/.zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

zstyle :compinstall filename '/home/angelo/.zshrc'

autoload -Uz compinit
compinit -d ~/.zsh/.zcompdump

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh

# Autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlighting
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Created by `pipx` on 2024-11-08 17:51:52
export PATH="$PATH:/home/angelo/.local/bin:/home/angelo/.cargo/bin"

# Load Direnv 
eval "$(direnv hook zsh)"

# Zoxide.
eval "$(zoxide init zsh)"

