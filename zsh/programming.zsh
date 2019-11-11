export RUBY_CONFIGURE_OPTS=--with-jemalloc

# asdf version manager
source ~/.asdf/asdf.sh
source ~/.asdf/completions/asdf.bash

# Go
export GOPATH=$HOME/go
path=($GOPATH/bin $path)

# n - Node version management
export N_PREFIX=$HOME/.n
path=($N_PREFIX/bin $path)

# opam configuration
test -r ~/.opam/opam-init/init.zsh && . ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# .NET Core
export DOTNET_CLI_TELEMETRY_OPTOUT=true
path=($HOME/.dotnet/tools $path)
