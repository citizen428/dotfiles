set -x EDITOR vim

### UI
set fish_pager_color_progress --background='red'
starship init fish | source

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish ; or true
