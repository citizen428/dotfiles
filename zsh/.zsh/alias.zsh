# global
alias -g C='|wc -l'
alias -g G='|grep'
alias -g H='|head'
alias -g L='|less'
alias -g SL='|sort|less'
alias -g S='|sort'
alias -g T='|tail'

# Use bat instead of cat
alias cat='bat --paging=never --style=plain --theme=Nord'

# Use exa instead of ls
alias l='exa -1a'
alias ll='exa -lh --git'
alias ls='exa'
alias la='ls -a'
alias lt='exa -lT --git'

alias g='git'
alias be='bundle exec'
alias mux='tmuxinator'
alias ducks='du -cks * | sort -rn | head'

# Homebrew
alias brewu='brew update && brew upgrade && brew cask upgrade'
alias brewc='brew cleanup'
alias bservl='brew services list'
alias bservr='brew services restart'
alias bservs='brew services start'
alias bservx='brew services stop'

# Kitty
alias icat='kitty +kitten icat'
alias kdiff="kitty +kitten diff"

# Ruby/Rails
alias r='bundle exec rake'

# Start webserver for current directory
alias serve='python -m http.server'

# Download with HTTPie
alias down='http --download'

# Don't nest nvim session
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
  if [ -x "$(command -v nvr)" ]; then
    alias nvim=nvr
  else
    alias nvim='echo "No nesting!"'
  fi
fi

alias zmv='noglob zmv -W'
