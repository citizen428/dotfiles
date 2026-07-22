HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zhistory
HISTORY_IGNORE="(ls|cd|pwd|exit|cd)*"

# Allow multiple terminal sessions to all append to one zsh command history
setopt APPEND_HISTORY

# Add commands as they are typed, don't wait until shell exit
setopt INC_APPEND_HISTORY

# Do not write events to history that are duplicates of previous events
setopt HIST_IGNORE_DUPS

# When searching history don't display results already cycled through twice
setopt HIST_FIND_NO_DUPS

# Remove extra blanks from each command line being added to history
setopt HIST_REDUCE_BLANKS

# Don't store history commands
setopt HIST_NO_STORE

# Do not record an event starting with a space.
setopt HIST_IGNORE_SPACE

# Autocomplete based on history
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward
