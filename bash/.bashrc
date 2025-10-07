# ~/.bashrc

# Exit if the shell is not interactive
[[ $- != *i* ]] && return

# Customize the shell prompt
# Shows: [username@hostname current-directory]$
PS1='[\u@\h \W]\$ '

# Load modular configuration files
[[ -f ~/.bash/.bash_aliases ]] && source ~/.bash/.bash_aliases
[[ -f ~/.bash/.bash_exports ]] && source ~/.bash/.bash_exports

# Enable bash completion if availableg
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Improve shell history behavior
HISTSIZE=10000            # Number of commands to remember in memory
HISTFILESIZE=20000        # Number of commands to save in .bash_history
HISTCONTROL=ignoredups:erasedups  # Avoid duplicate entries
shopt -s histappend       # Append to history file instead of overwriting
