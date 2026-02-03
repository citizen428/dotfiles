alias down='http --download'
alias ducks='du -cks * | sort -rn | head'
alias g='git'
alias lg='lazygit'
alias ipy='ipython'
alias m='git switch main'
alias mmv='noglob zmv -W'
alias reload='znap restart'
alias serve='python -m http.server --directory .'
alias weather='curl wttr.in/samui'

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

if (( $+commands[eza] )); then
    alias l='eza -1a'
    alias la='eza -a'
    alias ll='eza -lh --git'
    alias ls='eza'
    alias tree='eza -T'
fi

if (( $+commands[kitty] )); then
    alias icat='kitty +kitten icat'
    alias kdiff="kitty +kitten diff"
fi

if (( $+commands[rails] )); then
    alias be='bundle exec'
    alias by='bundle && yarn'
    alias r='bundle exec rails'
    alias rdbm='rails db:migrate'
    alias s='overmind start -f Procfile.dev'
    alias sp='bundle exec rspec'
fi

if (( $+commands[elixir] )); then
    alias i='iex'
    alias ips='iex -S mix phx.server'
    alias ism='iex -S mix'
    alias ist='iex -S mix test'
    alias mdgc='mix deps.get deps.compile'
    alias mem='mix ecto.migrate'
    alias mps='mix phx.server'
    alias mr='mix run'
fi

if [[ -d ~/.config/doom ]]; then
    alias dooms='doom sync && brew services restart emacs-plus@29'
fi

if (( $+commands[emacs] )); then
    alias ec='emacsclient -n'
fi

if [[ $OS = "Darwin" ]]; then
    alias brewu='brew update && brew upgrade'
    alias brewc='brew cleanup'
    alias bservl='brew services list'
    alias bservr='brew services restart'
    alias bservs='brew services start'
    alias bservx='brew services stop'
fi

if [[ $OS = "WSL" ]]; then
    alias pbcopy="w32yank.exe -o"
    alias pbpaste='w32yank.exe -i'
fi

if (( $+commands[docker] )); then
    alias docker-compose="docker compose"
fi
