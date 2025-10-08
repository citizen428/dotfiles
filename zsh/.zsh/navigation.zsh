# Auto changes to a directory without typing cd.
setopt AUTO_CD

# Push the old directory onto the stack on cd.
setopt AUTO_PUSHD

# Do not store duplicates in the stack.
setopt PUSHD_IGNORE_DUPS

# Do not print the directory stack after pushd or popd.
setopt PUSHD_SILENT

# Push to home directory when no argument is given.
setopt PUSHD_TO_HOME

# Change directory to a path stored in a variable.
setopt CDABLE_VARS

# Use extended globbing syntax.
setopt EXTENDED_GLOB

# Do not overwrite existing files with > and >>.
# Use >! and >>! to bypass.
unsetopt CLOBBER

alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

if [[ $OS = "Darwin" ]]; then
    hash -d dropb="$HOME/Library/CloudStorage/Dropbox"
    hash -d nix="$HOME/.config/nix"
    hash -d nvim="$HOME/.config/nvim"
fi

if [[ $OS = "WSL" ]]; then
    hash -d wind=/mnt/c/Users/me/Downloads
fi
