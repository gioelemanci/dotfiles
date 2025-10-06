# ~/.bash_aliases

alias n='nvim'

# Package management
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias remove='sudo pacman -Rns'

# Navigation and file listing
alias ..='cd ..'
alias ....='cd ../..'
alias c='clear'
alias ls='ls --color=auto -F'
alias la='ls --color=auto -A'
alias ll='ls --color=auto -alF'

# Search tools
alias grep='grep --color=auto'
alias f='fzf'

# Utilities
alias cat='batcat --style=plain'
alias top='btop'
alias df='df -h'
alias du='du -h'

# Git shortcuts
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push -u origin'
alias gl='git log --oneline --graph --decorate'
