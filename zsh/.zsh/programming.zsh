# asdf version manager
if (( $+commands[asdf] )); then
    if if [[ -v HOMEBREW_PREFIX ]]; then
        source $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh
    else
        source $HOME/.asdf/asdf.sh
    fi
fi

# pnpm
if (( $+commands[pnpm] )); then
    export PNPM_HOME=$(pnpm store path|sed 's#/store/v3##')
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
fi

# Python
if [[ -d $HOME/.poetry ]]; then
    path=($HOME/.poetry/bin $HOME/.local/bin $PATH)
fi

# Ruby
if (( $+commands[ruby] )); then
    export RUBY_CONFIGURE_OPTS="--with-jemalloc"
    export DISABLE_SPRING="true"
fi

# Rust
if [[ -d $HOME/.cargo ]]; then
    path=($HOME/.cargo/bin $path)
fi
