#!/usr/bin/env bash


## Optimize sudo, package building, fonts, and boost WIFI power

echo "$LOGNAME ALL=NOPASSWD: ALL" | sudo tee /etc/sudoers.d/overrides > /dev/null

sudo sed -i 's/#BUILDDIR=\/tmp\/makepkg/BUILDDIR=\/tmp\/makepkg/;s/COMPRESSXZ=(xz -c -z -)$/COMPRESSXZ=(xz -c -z - --threads=0)/;s/CFLAGS="-march=x86-64 -mtune=generic -O2 -pipe -fstack-protector-strong"/CFLAGS="-march=native -O2 -pipe -fstack-protector-strong"/;s/CXXFLAGS="-march=x86-64 -mtune=generic -O2 -pipe -fstack-protector-strong"/CXXFLAGS="${CFLAGS}"/' /etc/makepkg.conf

sudo sed -i 's/#EnableAUR/EnableAUR/;s/#CheckAURUpdates/CheckAURUpdates/;s/#NoConfirmBuild/NoConfirmBuild/' /etc/pamac.conf

mkdir -p ~/.cache && ln -sf /tmp/ ~/.cache/bazel && ln -sf /tmp/ ~/.cache/pacaur

mkdir -p ~/.local/share/icons/default   # prevents error with fix_xcusor

sudo mkfontdir /usr/share/fonts/100dpi && sudo mkfontdir /usr/share/fonts/75dpi

sudo sed -i 's/#WIRELESS_REGDOM="BO"/WIRELESS_REGDOM="BO"/g' /etc/conf.d/wireless-regdom


## Patch blurlock to be cooler

echo -e '#!/bin/bash\nscrot /tmp/shot.png\nconvert /tmp/shot.png -paint 2 -modulate 80 /tmp/shot.png\n[[ -f ~/.i3/lock.png ]] && convert /tmp/shot.png  ~/.i3/lock.png -gravity center -composite -matte /tmp/shot.png\ni3lock -n -e -i /tmp/shot.png' | sudo tee /usr/bin/blurlock > /dev/null


## Extra ricey boot performance tweaks
## Disables Bad Power Management, Bluetooth, Webcams, Thunderbolt, Printers, Modems, Bonjour, and Core Dumps

sudo systemctl disable tlp cups-browsed org.cups.cupsd ModemManager

echo -e "vm.swappiness=10\nvm.vfs_cache_pressure=50\nnet.core.optmem_max = 40960\nnet.core.rmem_max = 16777216\nnet.core.wmem_max = 16777216\nnet.ipv4.tcp_rmem = 4096 87380 16777216\nnet.ipv4.tcp_wmem = 4096 65536 16777216\nnet.ipv4.tcp_no_metrics_save = 1\nnet.ipv4.tcp_moderate_rcvbuf = 1\nnet.core.netdev_max_backlog = 2500\nnet.ipv4.tcp_mem = 8388608 8388608 8388608" | sudo tee /etc/sysctl.conf > /dev/null

sudo sysctl -p > /dev/null

echo -e "blacklist amdgpu\nblacklist bluetooth\nblacklist btusb\nblacklist uvcvideo\nblacklist ipv6\nblacklist mousedev\nblacklist thunderbolt" | sudo tee /etc/modprobe.d/rice-blacklist.conf > /dev/null

sudo sed -i 's/strictatime/noatime/g' /usr/lib/systemd/system/tmp.mount

sudo sed -i 's/#Storage=external/Storage=none/g' /etc/systemd/coredump.conf

sudo sed -i 's/#SystemMaxUse=/SystemMaxUse=100M/;s/#RuntimeMaxUse=/RuntimeMaxUse=100Ms/;s/#MaxLevelStore=debug/MaxLevelStore=warning/;s/#MaxLevelSyslog=debug/MaxLevelSyslog=warning/' /etc/systemd/journald.conf



## Patch Sound Card Buffer

echo 'options snd-hda-intel bdl_pos_adj=48' | sudo tee /etc/modprobe.d/alsa.conf > /dev/null


## Tweaks for faster, quieter, more stable boot

sudo sed -i 's/#COMPRESSION="lz4"/COMPRESSION="lz4"/;s/#COMPRESSION_OPTIONS=""/COMPRESSION_OPTIONS="-9"/;s/filesystems fsck/filesystems/' /etc/mkinitcpio.conf

sudo cp  /usr/lib/systemd/system/systemd-fsck* /etc/systemd/system/

sudo grep -q 'StandardOutput' /etc/systemd/system/systemd-fsck-root.service || echo -e 'StandardOutput=null\nStandardError=journal+console' | sudo tee -a /etc/systemd/system/systemd-fsck-root.service /etc/systemd/system/systemd-fsck@.service > /dev/null

echo '"Manjaro" "quiet loglevel=3 nomodeset root=UUID='$(sudo blkid -s UUID -o value $(findmnt -no source -M /)) 'rootflags=rw,noatime rd.udev.log-priority=3 ipv6.disable=1 vt.global_cursor_default=0"' | sudo tee /boot/refind_linux.conf > /dev/null

sudo rm -f /etc/fstab # make systemd auto-mount / + tmpfs faster (no re-mounts)

sudo systemctl enable upower # explicitly load since it will load anyway


