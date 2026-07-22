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
if [[ -n $TMUX ]]; then
    bindkey  "^[[1~"  beginning-of-line
    bindkey  "^[[4~"  end-of-line
else
    bindkey  "^[[H"   beginning-of-line
    bindkey  "^[[F"   end-of-line
fi
bindkey  "^[[3~"  delete-char

# Alt/option + left/right arrow for word-wise navigation
if [[ $OS == "Darwin" ]]; then
    bindkey "^[^[[C" forward-word
    bindkey "^[^[[D" backward-word
else
    bindkey "^[[1;3C" forward-word
    bindkey "^[[1;3D" backward-word
fi
