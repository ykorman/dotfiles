#!/bin/bash

set -euo pipefail # strict mode

common_packages="curl wget git vim htop tmux tig stow"
ubuntu_packages=""
fedora_packages=""

podman_ubuntu_install() {
	. /etc/os-release
	echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
	curl -L "https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key" | sudo apt-key add -
	sudo apt update
	sudo apt -y install podman
}

package_ubuntu_install() {
	sudo apt update
	sudo apt install -y ${common_packages} ${ubuntu_packages}
}

link_dotfiles() {
	local stow_cmd="stow --stow --dotfiles -v --ignore \.swp --ignore extras -t ${HOME}"
	local dir

	# TODO: switch vim/.vim to vim/dot-vim when stow fixes issue #33
	for dir in bash bin git htop tig tmux vim ; do
		${stow_cmd} ${dir}
	done
}

windows_fonts() {
	git clone --depth=1 https://github.com/ryanoasis/nerd-fonts.git /mnt/C/Users/Public/
	echo "Run the following in PowerShell CMD:"
	echo "cd C:\Users\Public\nerd-fonts\patched-fonts"
	echo ".\install.ps1 Caskaydia*"
	echo "Then go to Windows Terminal Settings and set the 'Caskaydia Cove NF' font in the Appearance tab"
}

#package_ubuntu_install
#podman_ubuntu_install
link_dotfiles

# TODO:
# vim plugins:
#url = https://github.com/dominikduda/vim_current_word.git
#url = https://github.com/tpope/vim-sensible.git
#url = https://github.com/ntpeters/vim-better-whitespace.git
#url = https://github.com/NLKNguyen/papercolor-theme.git
#url = https://github.com/vim-airline/vim-airline-themes
#url = https://github.com/mbbill/undotree.git
#url = https://github.com/vim-airline/vim-airline
#url = https://github.com/dense-analysis/ale.git
# Tmux plugin:
# https://github.com/wfxr/tmux-power.git
# LiquidPrompt
# https://github.com/nojhan/liquidprompt.git
