[[ -z $ZPROF ]] || zmodload zsh/zprof

source ~/.zsh/plugins.zsh

source ~/.zsh/os.zsh
source ~/.zsh/alias.zsh
source ~/.zsh/bindings.zsh
source ~/.zsh/completion.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/history.zsh
source ~/.zsh/iterm2_shell_integration.zsh
source ~/.zsh/navigation.zsh
source ~/.zsh/programming.zsh
source ~/.zsh/tools.zsh
source ~/.zsh/ui.zsh

eval "$(zoxide init zsh)"

[[ -z $ZPROF ]] || zprof
