#!/bin/bash

##  Bulk packages installer
##  June 2018
##  MIT License
##
##  vlasebian


# user name
USER=vlasebian

# install options
ctf_tools=1


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
    indicator-keylock
	terminator
	unrar
    dirmngr
    irssi
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
    python
    python3.5
    python-dev
    python-pip
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
    nasm
    bless
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
    python-gi-cairo
    python-psutil
    irssi-scripts
    ca-certificates
    libcrypt-blowfish-perl
    libcrypt-dh-perl
    libcrypt-openssl-bignum-perl
    libmath-bigint-gmp-perl
)


add_repositories() {
    apt-get -y update;
    apt-get -y upgrade;

	apt-add-repository -y non-free;
	apt-add-repository -y contrib;
    # ppas do not work well with debian
	# add-apt-repository -y ppa:tsbarnes/indicator-keylock
    # add-apt-repository -y ppa:openjdk-r/ppa
    echo "deb http://ppa.launchpad.net/linuxuprising/java/ubuntu bionic main" | tee /etc/apt/sources.list.d/linuxuprising-java.list;
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 73C3DB2A;
}


install_packages() {
    apt-get -y update
    apt-get -y upgrade

    echo "======   Installing vim...    ======"
    apt-get -y install vim-gnome

    echo "======   Installing tools...     ======"
    apt-get -y install ${TOOLS[@]}

    echo "======   Installing dependencies... ======"
    apt-get -y install ${DEP[@]}

    echo "======   Installing languages... ======"
    apt-get -y install ${LANGS[@]}

    if [[ "$ctf_tools" -eq 1 ]]; then
        echo "======   Installing ctf tools... ======"
        apt-get -y install ${CTF[@]}
        pip install --upgrade pip
        pip install --upgrade pwntools
    fi

    echo "======   Installing atom...   ======"
	wget https://atom.io/download/deb -O atom.deb
	dpkg -i atom.deb
	rm -rf atom.deb
	
	echo "======   Installing boostnote...   ======"
	wget https://github.com/BoostIO/boost-releases/releases/download/v0.11.15/boostnote_0.11.15_amd64.deb -O boostnote.deb
	dpkg -i boostnote.deb
	rm -rf boostnote.deb
	
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

		# Link files and configure vim
		bash $HOME/.dotfiles/aux-scripts/link_dotfiles.sh $ctf_tools;

        # change ssh key permissions
        chmod 700 $HOME/.ssh
        chmod 644 $HOME/.ssh/id_rsa.pub
        chmod 600 $HOME/.ssh/id_rsa

		# clone notes
		mkdir -p $HOME/documents/notes
		git clone git@github.com:vlasebian/notes.git $HOME/documents/notes
		
		# clone snippets
		mkdir -p $HOME/.snipptes
		git clone git@github.com:vlasebian/snippets.git $HOME/.snippets

		# clone random-algorithms
		mkdir -p $HOME/.algorithms
		git clone git@github.com:vlasebian/random-algorithms.git $HOME/.algorithms

		# clone hw
		mkdir -p $HOME/documents/
		git clone git@github.com:vlasebian/homework.git $HOME/documents/homework

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
	sleep 2

	add_repositories;
	install_packages;
	add_configurations;
	make_user_specific_conf;

	echo "     #### Installation complete ! #### "

} 2> system-wide_errors.txt

main
