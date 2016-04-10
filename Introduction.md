# Introduction

Welcome to the developer doucmentation for NodeOS. NodeOS is a open source, high performance Operating System.

This documentation is aimed at all Javascript developers who want to use Node.js as their main Operating System, as well as anyone interested in NodeOS's design and performance. This document introduces you to NodeOS, while the remaining documentation shows you how to use NodeOS for developing on it.

# About NodeOS

NodeOS is a Node.js based operating system, built-off of the Linux kernel. The NodeOS Project is aiming to, and can already run on some of the following platforms:

- real hardware like desktops, laptops, or SoC's (Raspberry Pi)
- cloud providers like Joyent, Amazon or Rackspace
- virtual machines like QEmu, VirtualBox, VMWare and KVM
- PaaS providers like Heroku or Joyent's Manta
- container providers like Docker & Vagga

Core development is being done in layers. There could be some differences to adjust better to each target platform, but the general structure is:

- barebones custom Linux kernel with an initramfs that boots to a Node.js REPL
- initramfs Initram environment to mount the users partition & boot the system
- rootfs Read-only partition image to host Linux kernel and initramfs files
- usersfs multi-user environment with the same behaviour of traditional OSes
