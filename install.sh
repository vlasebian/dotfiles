#!/bin/bash

##  Bulk packages installer
##  June 2018
##  MIT License
##
##  vlasebian


# user name
USER=vlasebian

# install options
INSTALL_CTF_TOOLS=1


# Stuff that will be installed
TOOLS=(
    wget
    curl
    zip
    p7zip
    make
    inetutils-tools
    htop
    irssi
    vlc
    mediainfo
    ffmpeg
    tree
    bash-completion
    # firmware-atheros
    lshw
    gconf2
	libcurl4
    curl
	terminator
	unrar
    dirmngr
    irssi
    typora
    slack-desktop
)


LANGS=(
    gcc
    g++
    libcurl4-openssl-dev
    clang
    gdb
    openjdk-9*
    openjdk-8*
    oracle-java11-set-default
    python3
    python3-dev
    python3-pip
    nasm
    # gdc
)


CTF=(
    ltrace
    strace
    netcat
    gcc-multilib
    libpcap-dev
    libssl-dev
    libffi-dev
    build-essential
    # bless
    # radare2
    wireshark
)


DEP=(
    gconf-service
    gconf2
    gconf2-common
    libgconf-2-4
    gconf-defaults-service
    gir1.2-keybinder-3.0
    libkeybinder-3.0-0
    python3-gi-cairo
    python3-psutil
    irssi-scripts
    ca-certificates
    libcrypt-blowfish-perl
    libcrypt-dh-perl
    libcrypt-openssl-bignum-perl
    libmath-bigint-gmp-perl
)


# do not add ppa repositories, they are not for debian
add_repositories() {
    apt-get -y update;
    apt-get -y upgrade;

	apt-add-repository -y non-free;
	apt-add-repository -y contrib;

    # add typora repository
    wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
    add-apt-repository 'deb https://typora.io/linux ./'
}


install_packages() {
    apt-get -y update
    apt-get -y upgrade

    echo "======   Installing vim...    ======"
    apt-get -y install vim-gnome vim-common vim-addon-manager vim-youcompleteme
    vim-addon-manager install youcompleteme

    echo "======   Installing tools...     ======"
    apt-get -y install ${TOOLS[@]}

    echo "======   Installing dependencies... ======"
    apt-get -y install ${DEP[@]}

    echo "======   Installing languages... ======"
    apt-get -y install ${LANGS[@]}

    if [[ "$INSTALL_CTF_TOOLS" -eq 1 ]]; then
        echo "======   Installing ctf tools... ======"
        apt-get -y install ${CTF[@]}
        pip3 install --upgrade pwntools
    fi

    echo "======   Installing atom...   ======"
	wget https://atom.io/download/deb -O atom.deb
	dpkg -i atom.deb
	rm -rf atom.deb

	apt-get update --fix-missing;
	apt-get autoremove;
	apt-get clean;
}


add_configurations() {

	# set hostname or wifi hotspot won't work
	hostnamectl --pretty set-hostname onmiovn

	# limit switching apps (Alt - Tab shorcut) to current workspace
	gsettings set org.gnome.shell.window-switcher current-workspace-only true
	gsettings set org.gnome.shell.app-switcher current-workspace-only true

}


make_user_specific_conf() {

	sudo -u "$USER" -i /bin/bash - <<-'EOF'
	{
        # Install fzf
        git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
        source $HOME/.fzf/install
	
        # Install Vundle
        git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim;

		# Link files and configure vim
		bash $HOME/.dotfiles/aux-scripts/link_dotfiles.sh $INSTALL_CTF_TOOLS;

        # change ssh key permissions
        chmod 700 $HOME/.ssh
        chmod 644 $HOME/.ssh/id_rsa.pub
        chmod 600 $HOME/.ssh/id_rsa

        # make a directory for repos
        mkdir $HOME/.repos

		# clone notes
		mkdir -p $HOME/.repos/notes
		git clone git@github.com:vlasebian/notes.git $HOME/.repos/notes
		
		# clone snippets
		mkdir -p $HOME/.repos/snippets
		git clone git@github.com:vlasebian/snippets.git $HOME/.repos/snippets

		# clone random-algorithms
		mkdir -p $HOME/.repos/algorithms
		git clone git@github.com:vlasebian/random-algorithms.git $HOME/.repos/algorithms

		# clone hw
		mkdir -p $HOME/.repos/homework
		git clone git@github.com:vlasebian/homework.git $HOME/.repos/homework

        # clone sec
		mkdir -p $HOME/.repos/ctf
        git clone git@github.com:vlasebian/ctf.git $HOME/.repos/ctf

	} 2> user-wide_errors.txt
	EOF

}


main() {

	# check if script is run with sudo, if not, exit with code 1
	if [[ $UID != 0 ]]; then
	    echo "Please run this script with sudo:"
	    echo "sudo $0 $*"
	    exit 1
	fi

	echo "# Hope you have your keys copied in the system! Here we go ..."
	sleep 5

	add_repositories;
	install_packages;
	add_configurations;
	make_user_specific_conf;

	echo "     #### Installation complete ! #### "

} 2> system-wide_errors.txt

main
