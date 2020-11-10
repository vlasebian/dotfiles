#!/usr/bin/env bash

PACKAGES=(
    # Essential packages used for installing other packages.
    build-essential # build tools
    apt-transport-https # vscode, docker
    ca-certificates # docker
    gnupg-agent # docker
    software-properties-common # docker

	# Main tools that i use in my workflow.
    vim
    terminator
    typora
    code

    # Command line tools.
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
    wireshark

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

    # Web development.
    nodejs

    # Docker
    docker-ce
    docker-ce-cli
    containerd.io
)

