#!/bin/bash
totalPac=$(checkupdates | wc -l)
totalAur=$(cower -u 2> /dev/null | wc -l)

check=$((totalPac + totalAur))
if [[ "$check" != "0" ]]
then
    pac="$totalPac"
    icon="%{F#ec5f67}%{F-}"
    aur="$totalAur"
#    echo "%{A1:pamac-updater &: A3:pamac-manager &:}$pac $icon $aur%{A-}%{A-}"
    echo "%{A1:pamac-updater &: A3:pamac-manager &:}$icon%{A-}%{A-}"
fi
