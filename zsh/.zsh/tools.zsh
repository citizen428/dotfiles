export EDITOR=vim

# fzf
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Homebrew
if [[ $OS = "Darwin" ]]; then
    export CONFIGURE_OPTS="--with-readline-dir=${HOMEBREW_PREFIX}/opt/readline"
fi

# Use nvim as man pager
if (( $+commands[nvim] )); then
    export MANPAGER='nvim +Man! -c "set winbar="'
fi

# !Password SSH agent
OP_AGENT_SOCK=~/.config/1password/agent.sock
if [[ -r $OP_AGENT_SOCK ]]; then
    export SSH_AUTH_SOCK=$OP_AGENT_SOCK
fi

if (( $+commands[direnv] )); then
    znap eval direnv "direnv hook zsh"
fi

private flyctl_install="${HOME}/.fly"
if [[ -d $flyctl_install ]]; then
    export FLYCTL_INSTALL=$flyctl_install
    path=("${FLYCTL_INSTALL}/bin" $path)
fi
