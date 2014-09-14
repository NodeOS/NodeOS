[![Stories in Ready](https://badge.waffle.io/NodeOS/NodeOS.png?label=ready&title=Ready)](https://waffle.io/NodeOS/NodeOS)
# node-os

Lightweight operating system using [Node.js](http://nodejs.org) as userspace.

Node-os wants to bring npm to the entire system.
Any package in npm is a node-os package,
which at last count was 94,070 packages.
The goal of node-os is to provide just enough to let npm provide the rest.
Since anyone can contribute to npm, anyone can create node-os packages.

[![Join the Discussion](http://i.imgur.com/hUjSLXt.png)](https://github.com/NodeOS/NodeOS/issues)

## find us

- Web: please use [github issues](https://github.com/NodeOS/NodeOS/issues) for discussion
- IRC: join `#node-os` on Freenode

## state of the union

- [node-os.com](http://node-os.com)
- [quick start tutorial](http://node-os.com/blog/get-involved)
- [build from source with docker](https://github.com/NodeOS/Docker-NodeOS)
- [view packages for node-os on npkg.org](http://npkg.org)

## introduction

NodeOS is a Node.js based operating system, built-off of the Linux kernel.
The eventual goal of NodeOS is to produce images that can be run on

- hardware
- cloud providers like Joyent/Amazon/Rackspace
- local virtual machines, like VirtualBox, VMWare, and KVM
- PaaS providers like Heroku, or Joyent's Manta
- container providers, like Docker

Core development is being done in layers:

- *kernel*    boot loader and kernel (currently provided by Docker)
- *initramfs* Node.js binary and its required shared libraries
- *rootfs*    NodeOS boot additions (and single-user environment)
- *usersfs*   multi-user environment

All the layers except *kernel* are bootable, leading both *initramfs* and
*rootfs* to a Node.js [REPL](http://nodejs.org/api/repl.html) prompt by default.

If you are hacking on NodeOS as a somewhat production server, you are likely
building *usersfs* images.

# NodeOS on Docker

- Please first [Install Docker](http://docs.docker.io/en/latest/installation/)

## Quick Start

- One Liner

    ```bash
    sudo docker run -t -i nodeos/nodeos
    ```

- or learn how to make a [Custom Build](http://node-os.com/blog/get-involved/)

## Build from Source

*Warning*: the build process is hairy, it probably won't work the first time.
I'm working on that.

```bash
git clone git@github.com:NodeOS/Docker-NodeOS.git
cd Docker-NodeOS
./build
```

# NodeOS on QEmu

The steps are similar to Docker ones, just type

```bash
PLATFORM=qemu ./build
```
