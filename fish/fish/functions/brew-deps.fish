function brew-deps
    brew list | while read cask
        set_color --bold
        echo -n "$cask ->"
        set_color normal
        brew deps $cask | awk '{printf(" %s ", $0)}'
        echo ""
    end
end
