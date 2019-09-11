#!/bin/bash

## This script is used for modifying user directories and for linking dotfiles
## July 2018
## MIT License
##
## vlasebian
##
## Run this script as current user, not as root!

SEC_TOOLS=$1

PACK=$HOME/packages

# Modify main directories
mv $HOME/Downloads $HOME/downloads;
mv $HOME/Documents $HOME/documents;
mv $HOME/Pictures  $HOME/pictures;
mv $HOME/Public    $HOME/share;

mkdir $HOME/sec;
mkdir $HOME/work;
mkdir $HOME/work/random;
mkdir $HOME/uni;

rm -rf $HOME/Desktop;
rm -rf $HOME/Templates;
rm -rf $HOME/Music;
rm -rf $HOME/Videos;

# Check if directory exists, if not create it
if [ ! -d "$PACK" ]; then
    mkdir $PACK
fi;

# Link .vimrc
ln -sf "$HOME/.dotfiles/vim/vimrc" "$HOME/.vimrc";

# Install gdb peda
if [[ "$SEC_TOOLS" = true ]]; then
    git clone https://github.com/longld/peda.git $PACK/peda
    echo "source $PACK/peda/peda.py" >> $HOME/.dotfiles/system/.gdbinit
fi

# Link directories configuration
ln -sf "$HOME/.dotfiles/system/user-dirs.dirs" "$HOME/.config";

# Link .gitconfig
ln -sf "$HOME/.dotfiles/git/gitconfig" "$HOME/.gitconfig";

# Link .gdbinit
if [[ "$SEC_TOOLS" = true ]]; then
    ln -sf "$HOME/.dotfiles/system/gdbinit" "$HOME/.gdbinit";
fi

# Link .bash_profile, .bashrc, .bash_aliases
ln -sf "$HOME/.dotfiles/system/bash_profile" "$HOME/.bash_profile";
ln -sf "$HOME/.dotfiles/system/bash_aliases" "$HOME/.bash_aliases";
ln -sf "$HOME/.dotfiles/system/bashrc" "$HOME/.bashrc";

# Link terminator config
mkdir -p $HOME/.config/terminator/ 
ln -sf "$HOME/.dotfiles/system/terminator-config" "$HOME/.config/terminator/config";

# Link template files
ln -sf "$HOME/.dotfiles/templates" "$HOME/.templates";

# Link ssh config file
if [ ! -d "$HOME/.ssh" ]; then
    mkdir $HOME/.ssh
fi;

ln -sf "$HOME/.dotfiles/system/ssh_config" "$HOME/.ssh/config";