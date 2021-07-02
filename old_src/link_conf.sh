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

# Link directories configuration.
ln -sf "$HOME/.dotfiles/system/user-dirs.dirs" "$HOME/.config";

