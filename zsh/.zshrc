if [ -x /usr/libexec/path_helper ]; then
  eval `/usr/libexec/path_helper -s`
fi

source ~/.zsh/alias.zsh
source ~/.zsh/autoloads.zsh
source ~/.zsh/bindings.zsh
source ~/.zsh/completion.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/history.zsh
source ~/.zsh/navigation.zsh
source ~/.zsh/programming.zsh
source ~/.zsh/tools.zsh
source ~/.zsh/ui.zsh

source ~/.zsh/plugins.zsh
