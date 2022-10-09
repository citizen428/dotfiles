autoload -U colors && colors

export BAT_THEME='Nord'

export LC_ALL='en_US.UTF-8'

# LS_COLORS
dircolors=dircolors
if [[ $OS = "Darwin" ]]; then
    dircolors=gdircolors
fi
test -r ~/.dir_colors && _evalcache $dircolors ~/.dir_colors

eval "$(starship init zsh)"
