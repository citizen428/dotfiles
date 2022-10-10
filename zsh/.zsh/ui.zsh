autoload -U colors && colors

export BAT_THEME='Nord'

export LC_ALL='en_US.UTF-8'

# LS_COLORS
if [[ -r ~/.dir_colors ]]; then
    znap eval dircolors "$(whence -a dircolors gdircolors ) ~/.dir_colors"
fi

znap eval starship 'starship init zsh --print-full-init'
znap prompt
