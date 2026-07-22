export OS=$(uname -s)
if [[ $OS = 'Linux' && -f /etc/wsl.conf ]]; then
    export OS="WSL"
fi

case $OS in
    Darwin)
        export HOMEBREW_PREFIX=/opt/homebrew
        export HOMEBREW_NO_ENV_HINTS=true
        export CPPFLAGS="$CPPFLAGS -I $HOMEBREW_PREFIX/include"
        export LDFLAGS="$LDFLAGS -L $HOMEBREW_PREFIX/lib"
        znap eval homebrew "${HOMEBREW_PREFIX}/bin/brew shellenv"
        ;;
    Linux)
        export HOMEBREW_NO_ENV_HINTS=true
        ;;
    WSL)
        znap eval keychain "keychain --noask --quiet --eval --agents ssh"

        path=('/snap/bin' $path)
        path=('/mnt/c/Users/me/AppData/Local/Programs/Microsoft VS Code/bin/' $path)

        export HOST_IP=$(ip route |awk '/^default/{print $3}')
        export PULSE_SERVER="tcp:$HOST_IP"
        export DISPLAY="$HOST_IP:0.0"
        ;;
esac
