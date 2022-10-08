# Use the macoS path_helper for initial path setup if available
if [ -x /usr/libexec/path_helper ]; then
  eval `/usr/libexec/path_helper -s`
fi

# Emacs keybindings. We set this early so abbr works in alias.zsh.
bindkey -e

source ~/.zsh/plugins.zsh

source ~/.zsh/os.zsh
source ~/.zsh/alias.zsh
source ~/.zsh/bindings.zsh
source ~/.zsh/completion.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/history.zsh
source ~/.zsh/navigation.zsh
source ~/.zsh/programming.zsh
source ~/.zsh/tools.zsh
source ~/.zsh/ui.zsh
