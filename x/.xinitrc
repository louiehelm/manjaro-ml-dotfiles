#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)


# Locate main network card for polybar
export NET_CARD=`iw dev | awk '$1=="Interface"{print $2}'`

# GTK-2.0 RC files
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# QT5 style
export QT_STYLE_OVERRIDE=gtk

intel-virtual-output 

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/* ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi


exec dbus-launch --sh-syntax --exit-with-session i3 --shmlog-size 0
