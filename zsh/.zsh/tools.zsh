export EDITOR=vim

if (( $+commands[nix] )); then
    source /etc/profiles/per-user/me/etc/profile.d/hm-session-vars.sh
fi

if (( $+commands[mise] )); then
    eval "$(mise activate zsh)"
fi

# fzf
if (( $+commands[fzf] )); then
    eval "$(fzf --zsh)"
    export FZF_DEFAULT_COMMAND='fd --type f'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

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

if (( $+commands[broot] )); then
    source /Users/me/.config/broot/launcher/bash/br
fi

if [[ ${TERM} = "wezterm" && ${OS} = "Darwin" ]]; then
    path=(/Applications/WezTerm.app/Contents/MacOS/ $path)
fi

export HOMEBREW_NO_ANALYTICS=1
