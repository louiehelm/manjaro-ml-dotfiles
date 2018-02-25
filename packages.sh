#!/usr/bin/env bash

# Delete unwanted programs
sudo pacman -R --noconfirm hexchat manjaro-hello clipit vi gufw ufw vlc-nightly libcanberra volumeicon palemoon-bin gimp conky conky-i3

# Add fallback theme
sudo pacman -S --needed --noconfirm gnome-themes-standard gnome-icon-theme


# Update database, and upgrade packages
sudo pacman -Syyu

# Install pacaur
gpg --recv-keys --keyserver hkp://pgp.mit.edu 1EB2638FF56C0C53
yaourt -S --noconfirm pacaur
sudo grep -q "editpkgbuild=false" /etc/xdg/pacaur/config || echo "editpkgbuild=false\neditinstall=false" | sudo tee -a /etc/xdg/pacaur/config


# Install desired packages
#sudo pacman -Rdd --noconfirm vte3
sudo pacman -S --needed --noconfirm vte3-ng wget tmux rofi termite chromium mpv zsh numlockx qt5-styleplugins perl-anyevent-i3 zsh-autosuggestions hunspell-en lsof galculator gucharmap gnome-alsamixer cmatrix doge httping

pacaur -S -e --needed --noedit --noconfirm polybar-git python-pywal-git nerd-fonts-complete oh-my-zsh-git vim-lightline-git neofetch openblas-lapack sublime-text-dev

## Install Chromium security policies

sudo mkdir -p /etc/chromium/policies/managed/
sudo ln -sf ~/.config/chromium-policies.json /etc/chromium/policies/managed/chromium-policies.json


# Cache first wal run
wal -t -i $HOME/Pictures/Wallpapers -o $HOME/.config/script/wal-set

# Update font cache
fc-cache -fv

# Make vim / zsh settings work even with sudo
sudo ln -sf /usr/bin/vim /usr/bin/vi
sudo ln -sf ~/.vimrc /root/.vimrc
sudo ln -sf ~/.vim /root/.vim

sudo ln -sf ~/.zshrc /root/.zshrc
sudo ln -sf ~/.config/script /root/.config/script
sudo ln -sf ~/.cache/wal /root/.cache/wal


# Switch to Zsh / Oh My Zsh + patch prompt to not break
sudo sed -i 's/ prompt_status/#prompt_status/;s/\x27%~\x27/"${PWD\/#$HOME\/}"/;s/echo/print/;s/✚ //;s/✚//;s/●//;' /usr/share/oh-my-zsh/themes/agnoster.zsh-theme

sudo chsh -s $(which zsh) $LOGNAME
sudo chsh -s $(which zsh) root

