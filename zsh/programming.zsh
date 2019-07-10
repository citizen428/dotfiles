export DOTNET_CLI_TELEMETRY_OPTOUT=true
export RUBY_CONFIGURE_OPTS=--with-jemalloc

# asdf version manager
source ~/.asdf/asdf.sh
source ~/.asdf/completions/asdf.bash

# Go
export GOPATH=$HOME/go
path=($GOPATH/bin $path)

# opam configuration
test -r ~/.opam/opam-init/init.zsh && . ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# .NET Core
path=($HOME/.dotnet/tools $path)

