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
rm -rf ~/.config/dunst/dunstrc
rm -rf ~/.config/gtk-3.0/settings.ini
rm -rf ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml
rm -rf ~/termite



for d in `ls -d */`;
do
    ( stow $d )
done
