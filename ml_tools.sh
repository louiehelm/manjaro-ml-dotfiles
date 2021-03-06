#!/usr/bin/env bash

## Install dev tools via pacman so they're in package management

sudo pacman -S --needed --noconfirm cmake eigen go python-pip cython openmp python-docker python-docker-pycreds python-zope-interface python-mock python-olefile python-websocket-client python-mock python-setuptools python-pyparsing python-requests python-twisted python-txaio python-incremental python-constantly python-autobahn python-yaml python-ujson python-packaging python-appdirs python-pyglet swig docker python-pytest python-wheel python-werkzeug python-protobuf python-numpy python-scipy opencv mathjax tk jupyter


gpg --recv-keys --keyserver hkp://pgp.mit.edu 48457EE0 # for bazel
pacaur -S --needed --noconfirm --noedit bazel i3lock-cac03-git libtinfo

rm -rf /tmp/bazel

sudo ln -sf /usr/lib/libtinfo.so /usr/lib/libtinfo.so.5


# Install MKL from AUR (can't build in ram -- too big)
BUILDDIR=~/.cache/ pacaur -S --needed --noconfirm --noedit intel-mkl
rm -rf ~/.cache/intel-parallel-studio-xe
rm -rf /tmp/intel-parallel-studio-xe

# Give mkl a knowable location
sudo ln -sf /opt/intel/*/linux/mkl /opt/intel/mkl

./tensorflow.sh

# Build after TF for API matching
./mkl_numpy_scipy_opencv.sh

## Install Gym + Universe from leading edge source

sudo pip install git+https://github.com/openai/gym.git
sudo pip install "gym[atari]"
sudo pip install git+https://github.com/openai/universe.git

## Add yourself to docker group
#sudo gpasswd -a $LOGNAME docker

## Start Docker service
#sudo systemctl start docker
#sudo systemctl enable docker
