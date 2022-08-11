abbr -a d cdh
abbr -a down 'http --download'
abbr -a ducks 'du -cks * | sort -rn | head'
abbr -a g git
abbr -a m 'git switch main'
abbr -a mux tmuxinator
abbr -a serve 'python -m http.server'

if type -p bat &> /dev/null
  alias cat 'bat --paging=never --style=plain --theme=Nord'
  alias catn 'cat -n'
end

if type -p exa &> /dev/null
  alias l 'exa -1a'
  alias la 'exa -a'
  alias ll 'exa -lh --git'
  alias ls exa
  alias lt 'exa -lT --git'
end

if type -p kitty &> /dev/null
  abbr -a icat 'kitty +kitten icat'
  abbr -a kdiff 'kitty +kitten diff'
end

if type -p rails &> /dev/null
  abbr -a be 'bundle exec'
  abbr -a by 'bundle && yarn'
  abbr -a r 'bundle exec rails'
  abbr -a rdbm 'rails db:migrate'
  abbr -a s 'overmind start -f Procfile.dev'
  abbr -a sp 'bundle exec rspec'
end

if [ $OSTYPE = "Darwin" ]
  abbr -a brewc 'brew cleanup'
  abbr -a brewu 'brew update && brew upgrade'
  abbr -a bservl 'brew services list'
  abbr -a bservr 'brew services restart'
  abbr -a bservs 'brew services start'
  abbr -a bservx 'brew services stop'
  abbr -a obs 'fm --start-dir=$HOME/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Private/'
end
