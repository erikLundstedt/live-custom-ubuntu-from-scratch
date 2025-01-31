#!/bin/env bash

# This script provides common customization options for the ISO
# 
# Usage: Copy this file to config.sh and make changes there.  Keep this file (default_config.sh) as-is
#   so that subsequent changes can be easily merged from upstream.  Keep all customiations in config.sh

# The version of Ubuntu to generate.  Successfully tested: bionic, cosmic, disco, eoan, focal, groovy
# See https://wiki.ubuntu.com/DevelopmentCodeNames for details
export TARGET_UBUNTU_VERSION="focal"

# The packaged version of the Linux kernel to install on target image.
# See https://wiki.ubuntu.com/Kernel/LTSEnablementStack for details
export TARGET_KERNEL_PACKAGE="linux-generic"

# The file (no extension) of the ISO containing the generated disk image,
# the volume id, and the hostname of the live environment are set from this name.
export TARGET_NAME="ubuntu-from-scratch"

# The text label shown in GRUB for booting into the live environment
export GRUB_LIVEBOOT_LABEL="Try Ubuntu FS without installing"

# The text label shown in GRUB for starting installation
export GRUB_INSTALL_LABEL="Install Ubuntu FS"

# Packages to be removed from the target system after installation completes succesfully
export TARGET_PACKAGE_REMOVE="
	ubiquity \
		casper \
		discover \
		laptop-detect \
		os-prober \
		"

# Package customisation function.  Update this function to customize packages
# present on the installed system.
function customize_image() {



	printf "\n**********\tinstall pacstall git and pacget\t**********\n"
	#apt-get -y install curl
	#curl -fsSL https://git.io/Jue3Z| bash
	bash -c "$(wget -q https://git.io/Jue3Z -O -)"

	printf "\n**********\tinstall things using pacstall\t**********\n"
 #pacstall --disable-prompts -I #example line
	pacstall --disable-prompts -I git

	#printf "\n**********\tinstall git and yadm\t**********\n"
	#apt-get install -y  git yadm
	pacstall --disable-prompts -I pacget-git
	pacstall --disable-prompts -I neovim-git


	pacstall --disable-prompts -I st-distrotube
    pacstall --disable-prompts -I dmenu-distrotube

	#    pacstall -I emacs-git
	printf "\n**********\tinstall using apt\t**********\n"
apt-get install -y \
    openjdk-8-jdk \
    openjdk-8-jre

	# useful tools
	apt-get install -y \
		clamav-daemon \
		kitty \
		apt-transport-https \
		aptitude \
		nano \
		less

	# purge
	apt-get purge -y \
		transmission-gtk \
		transmission-common \
		gnome-mahjongg \
		gnome-mines \
		gnome-sudoku \
		aisleriot \
		hitori



	# install graphics and desktop
	apt-get install -y \
		build-essential \
		libpam0g-dev \
		libxcb-xkb-dev
	git clone https://github.com/nullgemm/ly.git
	cd ly
	make github
	make
	make install
	systemctl enable ly.service

	pacstall --disable-prompts -I awesome-git




}

# Used to version the configuration.  If breaking changes occur, manual
# updates to this file from the default may be necessary.
export CONFIG_FILE_VERSION="0.3"
