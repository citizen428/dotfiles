# emacs
if (( $+commands[emacs] )); then
    path=("$HOME/.config/emacs/bin" $path)
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
if [[ -d $HOME/.poetry ]]; then
    path=($HOME/.poetry/bin $HOME/.local/bin $PATH)
fi

# Rust
if [[ -d $HOME/.cargo ]]; then
    source "$HOME/.cargo/env"
    path=($HOME/.cargo/bin $path)
fi

# Dart
if (( $+commands[dart] )); then
    path=($HOME/.pub-cache/bin $path)
fi

# Haskell
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

# Google Cloud
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
    source "$HOME/google-cloud-sdk/path.zsh.inc"
fi

if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then
    source "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

# Node (Nix)
if [[ -d $HOME/.npm-global ]]; then
    path=($HOME/.npm-global/bin $path)
fi

# PHP
if (( $+commands[composer] )); then
    path=($HOME/.config/composer/vendor/bin $path)
fi

# OCaml
if [ -f "$HOME/.opam/opam-init/init.zsh" ]; then
    source "$HOME/.opam/opam-init/init.zsh" > /dev/null 2> /dev/null
fi
