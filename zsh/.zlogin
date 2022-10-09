# Execute code in the background to not affect the current session
(
    # <https://github.com/zimfw/zimfw/blob/master/login_init.zsh>
    setopt LOCAL_OPTIONS EXTENDED_GLOB
    autoload -U zrecompile
    local ZSHCONFIG=~/.zsh

    # Compile zcompdump, if modified, to increase startup speed.
    zcompdump="${HOME}/.zcompdump"
    if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
        zrecompile -pq "$zcompdump"
    fi

    # zcompile .zshrc
    zrecompile -pq ${HOME}/.zshrc
    zrecompile -pq ${HOME}/.zprofile
    zrecompile -pq ${HOME}/.zshenv

    # recompile all zsh
    for f in $ZSHCONFIG/**/*.*sh; do
        zrecompile -pq $f
    done
) &!
