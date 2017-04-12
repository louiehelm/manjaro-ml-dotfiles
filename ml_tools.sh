#!/usr/bin/env bash

## Install dev tools via pacman so they're in package management

sudo pacman -S --needed --noconfirm cmake eigen go python-pip cython openmp tmux python-docker python-docker-pycreds python-zope-interface python-mock python-olefile python-websocket-client python-mock python-setuptools python-pyparsing python-requests python-twisted python-txaio python-incremental python-constantly python-autobahn python-yaml python-ujson python-packaging python-appdirs python-pyglet swig docker python-pytest python-wheel python-werkzeug python-protobuf mathjax tk jupyter


gpg --recv-keys --keyserver hkp://pgp.mit.edu 48457EE0 # for bazel
pacaur -S --needed --noconfirm --noedit bazel i3lock-cac03-git libtinfo

sudo ln -sf /usr/lib/libtinfo.so /usr/lib/libtinfo.so.5


./mkl_numpy_scipy_opencv.sh

./tensorflow.sh

## Install Gym + Universe from leading edge source

sudo pip install git+https://github.com/openai/gym.git
sudo pip install git+https://github.com/openai/universe.git
