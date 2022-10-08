autoload -U zmv

function mcd() {
  mkdir -p "$1" && cd "$1";
}

function brew-deps() {
  brew list | while read cask; do
    echo -n "\e[1;34m$cask ->\e[0m"; brew deps $cask | awk '{printf(" %s ", $0)}'; echo "";
  done
}

function clone() {
  git clone $1
  cd $(basename ${1%.*})
}
