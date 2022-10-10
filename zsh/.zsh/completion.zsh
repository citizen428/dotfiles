if [[ $OS = "Darwin" ]]; then
    fpath=($HOMEBREW_PREFIX/share/zsh-completions $fpath)
fi

autoload -U compinit

# Only regenerate completions once per day
if [[ $(date +'%j') != $(date -r ${ZDOTDIR:-$HOME}/.zcompdump +'%j') ]]; then
    compinit
else
    compinit -C
fi

# Allow completion from within a word/phrase
setopt COMPLETE_IN_WORD

# When completing from the middle of a word, move the cursor to the end of the word
setopt ALWAYS_TO_END

zstyle ':completion:*' completer _complete _correct _approximate
zstyle ':completion:*' menu yes select
# Match lowercase letters as both lower- and uppercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

if [ -f ~/.config/exercism/exercism_completion.zsh ]; then
    source ~/.config/exercism/exercism_completion.zsh
fi
