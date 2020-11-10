#!/bin/bash

## Modify user directories and link configuration files.
## July 2018
## MIT License
##
## vlasebian
##
## Run this script as current user, not as root!


# Modify main directories.
mv $HOME/Downloads $HOME/downloads;
mv $HOME/Documents $HOME/documents;
mv $HOME/Pictures  $HOME/pictures;
mv $HOME/Public    $HOME/share;

mkdir $HOME/work;
mkdir $HOME/random;
mkdir $HOME/uni;

rm -rf $HOME/Desktop;
rm -rf $HOME/Templates;
rm -rf $HOME/Music;
rm -rf $HOME/Videos;

# PACK=$HOME/packages
# Check if directory exists, if not create it.
# if [ ! -d "$PACK" ]; then
#     mkdir $PACK
# fi;

# Link directories configuration.
ln -sf "$HOME/.dotfiles/system/user-dirs.dirs" "$HOME/.config";

# Link ssh config file.
if [ ! -d "$HOME/.ssh" ]; then
    mkdir $HOME/.ssh
fi;
ln -sf "$HOME/.dotfiles/system/ssh.conf" "$HOME/.ssh/config";

# Link .gitconfig.
ln -sf "$HOME/.dotfiles/git/gitconfig" "$HOME/.gitconfig";

# Link .vimrc.
ln -sf "$HOME/.dotfiles/vim/vimrc" "$HOME/.vimrc";

# Link .gdbinit.
ln -sf "$HOME/.dotfiles/gdb/gdbinit" "$HOME/.gdbinit";

# Link .bash_profile, .bashrc, .bash_aliases
ln -sf "$HOME/.dotfiles/system/bash_profile" "$HOME/.bash_profile";
ln -sf "$HOME/.dotfiles/system/bash_aliases" "$HOME/.bash_aliases";
ln -sf "$HOME/.dotfiles/system/bashrc" "$HOME/.bashrc";

# Link terminator config
mkdir -p $HOME/.config/terminator/ 
ln -sf "$HOME/.dotfiles/system/terminator.conf" "$HOME/.config/terminator/config";

