# asdf version manager
if command -q asdf
    if set -q HOMEBREW_PREFIX
        source $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.fish
    else
        source $HOME/.asdf/asdf.fish
    end
end

# pnpm
if command -q pnpm
    set -gx PNPM_HOME (pnpm store path|string replace "/store/v3" "")
    set -gx PATH "$PNPM_HOME" $PATH
end

# Go
if command -q go
    set -x GOPATH $HOME/go
    set -xp PATH $GOPATH/bin
    set -x GOPROXY direct
end

# .NET Core
if command -q dotnet
    set -x DOTNET_CLI_TELEMETRY_OPTOUT true
    set -x DOTNET_INTERACTIVE_CLI_TELEMETRY_OPTOUT true
    set -xp PATH $HOME/.dotnet/tools
end

# Python
if [ -d $HOME/.poetry ]
    set -x PATH $HOME/.poetry/bin $HOME/.local/bin $PATH
end

# Raku
if [ -d $HOME/.rakubrew ]
    $HOME/.rakubrew/bin/rakubrew init Fish | source
end

# Ruby
if command -q ruby
    set -x RUBY_CONFIGURE_OPTS --with-jemalloc
    set -x DISABLE_SPRING true
end

# Rust
if [ -d $HOME/.cargo ]
    set -xp PATH $HOME/.cargo/bin
end
