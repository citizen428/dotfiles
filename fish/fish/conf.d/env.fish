set -x EDITOR vim

if command -q nvim
    set -x MANPAGER 'nvim -c "colorscheme nord" -c "set mouse=a" +Man!'
end
