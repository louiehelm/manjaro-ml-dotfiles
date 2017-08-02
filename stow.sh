#!/usr/bin/env bash

sudo pacman -S --needed --noconfirm stow

sudo rm -rf ~/.i3
sudo rm -rf ~/.vim
sudo rm -rf ~/.vimrc
sudo rm -rf ~/.icons
sudo rm -rf ~/.themes
sudo rm -rf ~/.gtkrc-2.0
sudo rm -rf ~/.pam_environment
sudo rm -rf ~/.extend.Xresources
sudo rm -rf ~/.Xresources
sudo rm -rf ~/.xinitrc
sudo rm -rf ~/.config/compton.conf
sudo rm -rf ~/.config/mimeapps.list
sudo rm -rf ~/.config/dunst/dunstrc
sudo rm -rf ~/.config/gtk-3.0/settings.ini
sudo rm -rf ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml
sudo rm -rf ~/termite
sudo rm -rf ~/.zshrc



for d in `ls -d */`;
do
    ( stow $d )
done
