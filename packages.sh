#!/usr/bin/env bash

## Delete unwanted programs
sudo pacman -R flashplugin hexchat manjaro-hello bluez blueman clipit vi gufw ufw vlc-nightly libcanberra volumeicon palemoon-bin gimp

## Enable Broadcom Wifi 
sudo pacman -S --needed linux49-broadcom-wl

## Optimize mirrors, update database, and upgrade packages
sudo pacman-mirrors -g && sudo pacman -Syyu

## Actually update ram-image
sudo mkinitcpio -p linux49

## Install pacaur
gpg --recv-keys --keyserver hkp://pgp.mit.edu 1EB2638FF56C0C53
yaourt -S --noconfirm pacaur
sudo grep -q "editpkgbuild=false" /etc/xdg/pacaur/config || echo "editpkgbuild=false\neditinstall=false" | sudo tee -a /etc/xdg/pacaur/config


## Install desired packages
sudo pacman -S --needed --noconfirm stow gtkrc-reload termite chromium polybar mpv zsh numlockx gnome-themes-standard gnome-icon-theme qt5-styleplugins perl-anyevent-i3  hunspell-en lsof galculator gucharmap cmatrix doge httping

pacaur -S --needed --noedit --noconfirm nerd-fonts-complete oh-my-zsh-git zsh-autosuggestions-git vim-lightline-git neofetch openblas-lapack sublime-text-dev

# Make vim settings work even with sudo
sudo ln -sf ~/.vimrc /root/.vimrc
sudo ln -sf ~/.vim /root/.vim


## Switch to Zsh / Oh My Zsh + patch prompt to not break
chsh -s $(which zsh)

sudo sed -i 's/ prompt_status/#prompt_status/;s/\x27%~\x27/"${PWD\/#$HOME\/}"/;s/echo/print/;s/✚ //;s/✚//;s/●//;' ~/.oh-my-zsh/themes/agnoster.zsh-theme


