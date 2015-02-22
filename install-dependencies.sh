#! /usr/bin/env sh

#
# Install Ubuntu dependencies
# The dependencies of one level would be also needed for the next ones
#

# cross-compiler
sudo apt-get install -qq -y texinfo

# barebones
sudo apt-get install -qq -y bc qemu-system

# initramfs
sudo apt-get install -qq -y nodejs-legacy

# rootfs
sudo apt-get install -qq -y genext2fs grub-pc-bin ncurses-term
sudo apt-get install -qq -y bdf2psf unifont-bin
