#!/usr/bin/env bash

sudo pacman -S --needed --noconfirm stow

rm -rf ~/.i3
rm -rf ~/.vim
rm -rf ~/.vimrc
rm -rf ~/.icons
rm -rf ~/.themes
rm -rf ~/.gtkrc-2.0
rm -rf ~/.pam_environment
rm -rf ~/.extend.Xresources
rm -rf ~/.Xresources
rm -rf ~/.xinitrc
rm -rf ~/.config/compton.conf
rm -rf ~/.config/mimeapps.list
rm -rf ~/termite



for d in `ls -d */`;
do
    ( stow $d )
done
