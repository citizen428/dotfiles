export OS=$(uname -s)
if [[ $OS = 'Linux' && -f /etc/wsl.conf ]]; then
    export OS="WSL"
fi

if [[ $OS = "Darwin" ]]; then
    # Use the macoS path_helper for initial path setup if available
    path_helper=/usr/libexec/path_helper
    if [ -x $path_helper ]; then
        _evalcache $path_helper -s
    fi

    export HOMEBREW_PREFIX=/opt/homebrew
    export HOMEBREW_NO_ENV_HINTS=true
    export CPPFLAGS="$CPPFLAGS -I $HOMEBREW_PREFIX/include"
    export LDFLAGS="$LDFLAGS -L $HOMEBREW_PREFIX/lib"
    _evalcache $HOMEBREW_PREFIX/bin/brew shellenv
fi

if [[ $OS = "WSL" ]]; then
    _evalcache keychain --noask --quiet --eval --agents ssh

    path=('/snap/bin' $path)
    path=('/mnt/c/Users/me/AppData/Local/Programs/Microsoft VS Code/bin/' $path)

    export HOST_IP=$(ip route |awk '/^default/{print $3}')
    export PULSE_SERVER="tcp:$HOST_IP"
    export DISPLAY="$HOST_IP:0.0"
fi
