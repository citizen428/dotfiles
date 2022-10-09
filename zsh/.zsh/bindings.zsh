# Emacs keybindings
bindkey -e

# ESC-. inserts last word from previous command
bindkey '\e.' insert-last-word

# fn-backpace is del
bindkey "\e[3~" delete-char

# Edit command in editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line
