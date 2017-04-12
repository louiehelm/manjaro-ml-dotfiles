#!/usr/bin/env bash

for d in `ls -d */`;
do
    ( stow $d )
done
