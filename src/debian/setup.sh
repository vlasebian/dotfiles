#!/usr/bin/env bash

BASE_DIR=$(pwd)

UTILITIES=(
    build-essential # build tools
    wget
    zip
    p7zip
    htop
    tree
	unrar
    lshw
    irssi
    inetutils

    # Networking tools.
    netcat

    # Tracking tools.
    ltrace
    strace

    # Compilers and libraries.
    clang
    nasm
    gcc-multilib

    # Media software.
    vlc
    ffmpeg
)

install_terminator() {
    echo "# Installing terminator... #"
    apt install -y terminator
    mkdir -p "$HOME"/.config/terminator/ 
    ln -sf "$BASE_DIR"/terminator/terminator.conf "$HOME"/.config/terminator/config
    echo "# Finished installing terminator. #"
}

install_zsh() {
    echo "# Installing zsh... #"
    # 1. Install dependencies.
    # 2. Install package.
    # 3. Configure package (setup commands, link configurations etc.)
    echo "# Finished installing zsh. #"
}

install_tmux() {
    echo "# Installing tmux... #"
    # 1. Install dependencies.
    # 2. Install package.
    apt install -y tmux
    # 3. Configure package (setup commands, link configurations etc.)
    echo "# Finished installing tmux. #"
}

install_vim() {
    echo "# Installing vim... #"
    apt install -y nvim
    echo "# Finished installing vim. #"
}

install_vscode() {
    echo "# Installing vscode... #"
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg

    apt install -y apt-transport-https
    apt update  -y
    apt install -y code

    echo "# Finished installing vscode. #"
}

install_docker() {
    echo "TODO"
    # apt-transport-https        # vscode, docker
    # ca-certificates            # docker
    # gnupg-agent                # docker
    # software-properties-common # docker
    # Docker
    # docker-ce
    # docker-ce-cli
    # containerd.io
}

install_obsidian() {
    echo "TODO"
}

install_utilities() {
    for utility in "${UTILITIES[@]}"; do
        echo "# Installing $utility... #";
        sleep 1;
        apt-get -y install "$utility";
        echo "# Finished installing $utility. #";
    done
}

configure_bash() {
    ln -sf "$BASE_DIR"/bash/bashrc       "$HOME"/.bashrc;
    ln -sf "$BASE_DIR"/bash/bash_profile "$HOME"/.bash_profile;
    ln -sf "$BASE_DIR"/bash/bash_aliases "$HOME"/.bash_aliases;
}

run_debian_setup() {
    TODO
}
