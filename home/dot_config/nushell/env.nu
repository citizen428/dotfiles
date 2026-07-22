# env.nu
#
# Installed by:
# version = "0.113.0"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.
let autoload_path = $nu.default-config-dir | path join "autoload"

# fzf --nushell | save -f ($autoload_path | path join "fzf.nu")
mise activate nu | save -f ($autoload_path | path join "mise.nu")
starship init nu | save -f ($autoload_path | path join "starship.nu")
zoxide init nushell | save -f ($autoload_path | path join "zoxide.nu")

# Completions
$env.CARAPACE_BRIDGES = 'zsh,bash'
carapace _carapace nushell | save -f ($autoload_path | path join "carapace.nu")

