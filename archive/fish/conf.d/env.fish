set -x EDITOR vim

if command -q nvim
    set -x MANPAGER 'nvim +Man! -c "set winbar="'
end
