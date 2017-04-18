#!/usr/bin/env bash

## Install Chromium security policies

sudo mkdir -p /etc/chromium/policies/managed/
sudo ln -sf ~/.config/chromium-policies.json /etc/chromium/policies/managed/chromium-policies.json

## Install DNSCrypt + Unbound 

sudo mkdir -p /usr/local/share/dnscrypt-proxy && sudo curl -o /usr/local/share/dnscrypt-proxy/dnscrypt-resolvers.csv https://download.dnscrypt.org/dnscrypt-proxy/dnscrypt-resolvers.csv

sudo mkdir -p /etc/unbound && sudo curl -o /etc/unbound/root.hints https://www.internic.net/domain/named.cache

sudo pacman -S --needed --noconfirm dnscrypt-proxy unbound chromium

echo 'ResolverName dnscrypt.eu-nl' | sudo tee /etc/dnscrypt-proxy.conf > /dev/null

grep -q "127.0.0.1" /etc/resolv.conf || sudo mv /etc/resolv.conf /etc/resolv.conf.bak
sudo chattr -i /etc/resolv.conf
echo 'nameserver 127.0.0.1' | sudo tee /etc/resolv.conf > /dev/null
sudo chattr +i /etc/resolv.conf




echo -e 'server:\n    port: 53\n    do-ip4: yes\n    do-ip6: no\n    do-udp: yes\n    do-tcp: yes\n    log-queries: no\n    root-hints: "/etc/unbound/root.hints"\n    hide-identity: yes\n    hide-version: yes\n    prefetch: yes\n    do-not-query-localhost: no\n    qname-minimisation: yes\n    minimal-responses: yes\n    trust-anchor-file: trusted-key.key\n\nforward-zone:\n  name: "."\n  forward-addr: 127.0.0.1@5353' | sudo tee /etc/unbound/unbound.conf > /dev/null


sudo systemctl start dnscrypt-proxy

sudo systemctl stop dnscrypt-proxy
sudo sed -i 's/:53$/:5353/g' /etc/systemd/system/dnscrypt-proxy.socket
sudo sed -i 's/:53$/:5353/g' /etc/systemd/system/sockets.target.wants/dnscrypt-proxy.socket

sudo systemctl start dnscrypt-proxy unbound
sudo systemctl enable dnscrypt-proxy unbound

sudo systemctl is-active unbound dnscrypt-proxy


## Uncomment to install Profile Sync Daemon

#pacaur -S --needed --noconfirm --noedit profile-sync-daemon

#systemctl --user enable psd
#systemctl --user start psd
