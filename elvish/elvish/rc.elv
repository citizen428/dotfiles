set E:PATH = /run/current-system/sw/bin:/Library/TeX/texbin:/Users/me/.fly/bin:/Users/me/.pub-cache/bin:/Users/me/.cargo/bin:/Users/me/.dotnet/tools:/Users/me/.local/share/pnpm:/Users/me/.config/emacs/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/share/dotnet:~/.dotnet/tools:/Library/Apple/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Users/me/.local/bin:/Users/me/go/bin:/Users/me/.asdf/shims:/opt/homebrew/opt/asdf/libexec/bin:/opt/homebrew/opt/fzf/bin

use epm
epm:install &silent-if-installed         ^
github.com/zzamboni/elvish-modules

use path
use readline-binding

eval (starship init elvish)
use github.com/zzamboni/elvish-modules/iterm2
iterm2:init
# set edit:insert:binding[Ctrl-L] = $iterm2:clear-screen~

eval (zoxide init elvish | slurp)
