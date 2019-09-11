# global
alias -g C='|wc -l'
alias -g G='|grep'
alias -g H='|head'
alias -g L='|less'
alias -g SL='|sort|less'
alias -g S='|sort'
alias -g T='|tail'

# Use bat instead of cat
alias cat='bat --paging=never --style=plain'

# Use exa instead of ls
alias l='exa -1a'
alias ll='exa -lh --git'
alias ls='exa'
alias la='ls -a'
alias lt='exa -lT --git'

alias g='git'

# Homebrew
alias brewu='brew update && brew upgrade'
alias brewc='brew cleanup'
alias bservl='brew services list'
alias bservr='brew services restart'
alias bservs='brew services start'
alias bservx='brew services stop'

# Kitty
alias icat='kitty +kitten icat'
alias kdiff="kitty +kitten diff"

# Nix
alias nixc="nix-collect-garbage -d"
alias nixq="nix-env -qaP"
alias nixU="nix-channel --update && nix-env -iA nixpkgs.nix"
alias nixu="nix-env -u"

# Ruby/Rails
alias r='bundle exec rake'

# Start webserver for current directory
alias serve='python -m http.server'

alias vim='nvim'
