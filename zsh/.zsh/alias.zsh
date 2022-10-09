alias down='http --download'
alias ducks='du -cks * | sort -rn | head'
alias g='git'
alias m='git switch main'
alias mux='tmuxinator'
alias reload='exec zsh'
alias serve='python -m http.server'

# utility
alias -g C='|wc -l'
alias -g G='|grep'
alias -g H='|head'
alias -g L='|less'
alias -g SL='|sort|less'
alias -g S='|sort'
alias -g T='|tail'

if (( $+commands[bat] )); then
    alias cat='bat --paging=never --style=plain'
fi

if (( $+commands[exa] )); then
    alias l='exa -1a'
    alias la='ls -a'
    alias ll='exa -lh --git'
    alias ls='exa'
    alias lt='exa -lT --git'
fi

if (( $+commands[kitty] )); then
    alias icat='kitty +kitten icat'
    alias kdiff="kitty +kitten diff"
fi

if (( $+commands[rails] )); then
    alias be='bundle exec'
    alias by='bundle && yarn'
    alias  r='bundle exec rails'
    alias rdbm='rails db:migrate'
    alias s='overmind start -f Procfile.dev'
    alias sp='bundle exec rspec'
fi

if [[ $OS = "Darwin" ]]; then
    alias brewu='brew update && brew upgrade'
    alias brewc='brew cleanup'
    alias bservl='brew services list'
    alias bservr='brew services restart'
    alias bservs='brew services start'
    alias bservx='brew services stop'
    alias obs='fm --start-dir=$HOME/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Private/'
fi

# Don't nest nvim session
if [[ -n "$NVIM_LISTEN_ADDRESS" ]]; then
    if [[ -x "$(command -v nvr)" ]]; then
        alias nvim=nvr
    else
        alias nvim='echo "No nesting!"'
    fi
fi

alias zmv='noglob zmv -W'
