## Dotfiles, because my \$HOME is my castle

Hi I’m actor Troy McClure. You might remember me from such dotfile repositories as [citizen428/nvim-config](https://git.sr.ht/~citizen428/nvim-config).

## Installation

Maybe don't. These are my dotfiles and may not fit your workflow and/or preferences. Feel free to copy to your heart's content though.

However, there is an install script called `install.sh` which uses [GNU Stow](https://www.gnu.org/software/stow/). It can be used to install some or all of the dotfiles.

* Without arguments the script will interactively prompt for each toplevel group of dotfiles:
    ```
    $ ./install.sh
    Install asdf? [y/n] y
    Linking asdf in /home/user
    Install bin? [y/n] n
    Skipping bin
    ...
    ```
* Alternatively you can specify a list of groups to install:
    ```
    $ ./install.sh asdf ruby
    Linking asdf in /home/user
    Linking ruby in /home/user
    ```
