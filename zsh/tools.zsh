# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# # GPG for Git commit signing
export GPG_TTY=$(tty)

# Homebrew
export CONFIGURE_OPTS="--with-readline-dir=/usr/local/opt/readline"

# z
source /usr/local/etc/profile.d/z.sh

export EDITOR=vim

test -d ~/.nix-profile && source ~/.nix-profile/etc/profile.d/nix.sh
