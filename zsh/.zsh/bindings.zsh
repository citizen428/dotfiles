# Emacs keybindings
bindkey -e

WORDCHARS="${WORDCHARS/\/}"

# ESC-. inserts last word from previous command
bindkey '\e.' insert-last-word

# fn-backpace is del
bindkey "\e[3~" delete-char

# Edit command in editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Home, End, Del keys
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

# Alt/option + left/right arrow for word-wise navigation
bindkey "^[^[[C" forward-word
bindkey "^[^[[D" backward-word
