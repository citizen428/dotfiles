set -o emacs

keybd_trap () {
  case ${.sh.edchar} in
    $'\f')    .sh.edchar=$'\e\f';;  # clear-screen
    $'\e[1~') .sh.edchar=$'\001';;  # Home = beginning-of-line
    $'\e[4~') .sh.edchar=$'\005';;  # End = end-of-line
    $'\e[5~') .sh.edchar=$'\e>';;   # PgUp = history-previous
    $'\e[6~') .sh.edchar=$'\e<';;   # PgDn = history-next
    $'\e[3~') .sh.edchar=$'\004';;  # Delete = delete-char
  esac
}
trap keybd_trap KEYBD

PS1=`id -un`@`hostname -s`:'$PWD$ '
export PS1

function mcd { mkdir $1 && cd $1; }
