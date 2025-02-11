#!/bin/sh

make -j $(nproc --all) LOCALVERSION=-`date +%Y-%m-%d-%H-%M-%S`
