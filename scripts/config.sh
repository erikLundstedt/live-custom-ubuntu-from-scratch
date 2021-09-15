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

	#install pacstall git and pacget
	curl -fsSL https://git.io/Jue3Z | bash
	apt-get install git yadm
	pacstall -I git
	pacstall -I pacget-git
	pacstall -I neovim-git
	#    pacstall -I emacs-git
	pacstall -I dmenu-distrotube
	pacstall -I st-distrotube

apt-get install -y \
    openjdk-8-jdk \
    openjdk-8-jre

	# useful tools
	apt-get install -y \
		clamav-daemon \
		kitty \
		apt-transport-https \
		curl \
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

	pacstall -I awesome-git


	# install graphics and desktop







}

# Used to version the configuration.  If breaking changes occur, manual
# updates to this file from the default may be necessary.
export CONFIG_FILE_VERSION="0.3"
