# rtx runtime executor
if (( $+commands[rtx] )); then
    znap eval rtx "rtx activate zsh"
fi

# emacs
if (( $+commands[emacs] )); then
    path=("$HOME/.config/emacs/bin" $path)
fi

# pnpm
if (( $+commands[pnpm] )); then
    export PNPM_HOME="${HOME}/.local/share/pnpm"
    path=($PNPM_HOME $path)
fi

# Go
if (( $+commands[go] )); then
    export GOPATH="$HOME/go"
    path=($GOPATH/bin $path)
    export GOPROXY="direct"
fi

# .NET Core
if (( $+commands[dotnet] )); then
    export DOTNET_CLI_TELEMETRY_OPTOUT=true
    export DOTNET_INTERACTIVE_CLI_TELEMETRY_OPTOUT=true
    path=($HOME/.dotnet/tools $path)
fi

# Python
export PYTHONSTARTUP="$HOME/.pythonstartup.py"
if [[ -d $HOME/.poetry ]]; then
    path=($HOME/.poetry/bin $HOME/.local/bin $PATH)
fi

# Ruby
if (( $+commands[ruby] )); then
    export DISABLE_SPRING="true"
fi

# Rust
if [[ -d $HOME/.cargo ]]; then
    path=($HOME/.cargo/bin $path)
fi

# Dart
if (( $+commands[dart] )); then
    path=($HOME/.pub-cache/bin $path)
fi

# Haskell
[ -f "/Users/me/.ghcup/env" ] && source "/Users/me/.ghcup/env"

# Google Cloud
if [ -f '/Users/me/google-cloud-sdk/path.zsh.inc' ]; then
    source '/Users/me/google-cloud-sdk/path.zsh.inc'
fi

if [ -f '/Users/me/google-cloud-sdk/completion.zsh.inc' ]; then
    source '/Users/me/google-cloud-sdk/completion.zsh.inc'
fi
