export EDITOR=vim

# fzf
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Use bat as man pager
if (( $+commands[bat] )); then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# 1Password SSH agent
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

private op_plugins=$HOME/.config/op/plugins.sh
[[ -f $op_plugins ]] && source $op_plugins

private fzf_config=$HOME/.fzf.zsh
[[ -f $fzf_config ]] && source $fzf_config

if [[ $OS = "Darwin" ]]; then
    private latex_dir=/Library/TeX/texbin
    if [[ -d $latex_dir ]]; then
        path=($latex_dir $path)
    fi
fi
