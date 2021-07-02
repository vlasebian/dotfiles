#!/bin/bash

## Clone repos and install tools from repos.
## July 2018
## MIT License
##
## vlasebian
##
## Run this script as current user, not as root!


CYBERSEC_TOOLS=$1

# Install Vundle.
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim;

# Install fzf.
#git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf;
#source $HOME/.fzf/install;

# Install gdbpeda.
if [[ "$CYBERSEC_TOOLS" = true ]]; then
    git clone https://github.com/longld/peda.git ~/.peda;
    echo "source ~/.peda/peda.py" > ~/.gdbinit;
fi

# Clone notes.
mkdir -p $HOME/notes;
git clone git@github.com:vlasebian/notes.git $HOME/notes;
    
# Clone code snippets.
mkdir -p $HOME/snippets;
git clone git@github.com:vlasebian/snippets.git $HOME/snippets;

# Clone algorithms.
mkdir -p $HOME/algorithms;
git clone git@github.com:vlasebian/random-algorithms.git $HOME/algorithms;

# Clone homework.
mkdir -p $HOME/.homework;
git clone git@github.com:vlasebian/homework.git $HOME/.homework;

# Clone cybersec resources.
mkdir -p $HOME/cybersec;
git clone git@github.com:vlasebian/ctf.git $HOME/cybersec;

