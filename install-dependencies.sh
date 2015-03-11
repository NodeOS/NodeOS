#! /usr/bin/env sh

#
# Install Ubuntu dependencies
# The dependencies of one level would be also needed for the next ones
#

# cross-compiler
apt-get install -qq -y texinfo

# barebones
apt-get install -qq -y bc qemu-system

# initramfs
apt-get install -qq -y nodejs-legacy

# rootfs
apt-get install -qq -y genext2fs grub-pc-bin ncurses-term
apt-get install -qq -y bdf2psf unifont-bin
