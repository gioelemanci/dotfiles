# ~/.zshrc

# Initialization code that may require console input (password prompts, [y/n] confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Prompt
PROMPT='%n@%m %1~ %# '

# Load modular config files
[[ -f ~/.zsh/.zsh_aliases ]] && source ~/.zsh/.zsh_aliases
[[ -f ~/.zsh/.zsh_exports ]] && source ~/.zsh/.zsh_exports
[[ -f ~/.zsh/.zsh_plugins ]] && source ~/.zsh/.zsh_plugins
[[ -f ~/.zsh/.p10k.zsh ]] && source ~/.zsh/.p10k.zsh

# Enable completion system
ZCOMPDUMP=~/.zsh/.zcompdump
autoload -Uz compinit
compinit

# Improve history behavior
HISTSIZE=10000
SAVEHIST=20000
HISTFILE=~/.zsh/.zsh_history
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
