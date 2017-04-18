#!/usr/bin/env bash

sudo pacman -S --needed --noconfirm stow

rm -rf ~/.i3

for d in `ls -d */`;
do
    ( stow $d )
done
