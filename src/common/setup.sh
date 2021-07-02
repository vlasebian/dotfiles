#!/usr/bin/env bash

BASE_DIR=$(pwd)

# Load environment variables.
source "$BASE_DIR"/env.sh

configure_ssh() {
    echo "# Configuring ssh... #"

    if [ ! -d "$HOME"/.ssh ]; then
        mkdir "$HOME"/.ssh
    fi;

    # Link ssh config file.
    ln -sf "$BASE_DIR"/ssh/ssh.conf "$HOME"/.ssh/config;

    echo "# Finished configuring ssh. #"
}

configure_git() {
    echo "# Configuring git... #"

    ln -sf "$BASE_DIR"/git/gitconfig "$HOME"/.gitconfig;

    git config --global user.email "$GIT_GLOBAL_EMAIL"

    echo "# Finished configuring git. #"
}

configure_zsh() {
    echo "# Configuring zsh... #"
    # TODO
    echo "# Finished configuring zsh. #"
}

configure_tmux() {
    echo "# Configuring tmux... #"
    # TODO
    echo "# Finished configuring tmux. #"
}

configure_vim() {
    echo "# Configuring vim... #"

    # Install Vundle.
    git clone https://github.com/VundleVim/Vundle.vim.git "$HOME"/.vim/bundle/Vundle.vim;

    mkdir -p "$HOME"/.config/nvim
    ln -sf "$BASE_DIR"/vim/vimrc "$HOME"/.config/nvim/init.vim
    ln -sf "$BASE_DIR"/vim/vimrc "$HOME"/.vimrc
    ln -sf /usr/bin/nvim /usr/local/bin/vim
    vim +PluginInstall +qall

    echo "# Finished configuring vim. #"
}

configure_fzf() {
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME"/.fzf;
    source "$HOME"/.fzf/install;
}

configure_gdb() {
    # Link .gdbinit.
    ln -sf "$BASE_DIR"/gdb/gdbinit "$HOME"/.gdbinit;
}

