[![Build Status](https://semaphoreapp.com/api/v1/projects/71d72807-779a-40d3-a8d4-523cd0a52eb3/356164/shields_badge.svg)](https://semaphoreapp.com/nodeos/nodeos)
[![Stories in Ready](https://badge.waffle.io/NodeOS/NodeOS.png?label=ready&title=Ready)](https://waffle.io/NodeOS/NodeOS)
# NodeOS

Lightweight operating system using [Node.js](http://nodejs.org) as userspace.

NodeOS is an operating system build entirely in Javascript and managed by npm. Any package in npm is a NodeOS package, which at last count was 106,713 packages. The goal of NodeOS is to provide just enough to let npm provide the rest. Since anyone can contribute to npm, anyone can create NodeOS packages.
[Roadmap](https://github.com/NodeOS/NodeOS/issues/37)

[![Join the Discussion](http://i.imgur.com/hUjSLXt.png)](https://github.com/NodeOS/NodeOS/issues)

## find us

- Web: please use [github issues](https://github.com/NodeOS/NodeOS/issues) for discussion
- IRC: join `#node-os` on Freenode

## introduction

NodeOS is a Node.js based operating system, built-off of the Linux kernel.
The eventual goal of NodeOS is to produce images that can be run on

- **real hardware** like desktop PCs, servers or Raspberry Pi
- **cloud providers** like Joyent, Amazon or Rackspace
- **virtual machines** like QEmu, VirtualBox, VMWare and KVM
- **PaaS providers** like Heroku or Joyent's Manta
- **container providers** like Docker

Core development is being done in layers. There could be some differences to
adjust better to each target platform, but the general structure is:

- *barebones* custom Linux kernel with an initramfs that boots to a Node.js REPL
- *initramfs* Basic NodeOS environment to mount a root filesystem partition
- *rootfs*    NodeOS global services, C/C++ compiler and libraries
- *usersfs*   multi-user environment with the same behaviour of traditional OSes

All the layers except *kernel* are bootable, leading both *initramfs* and
*rootfs* to a Node.js [REPL](http://nodejs.org/api/repl.html) prompt by default.

If you are hacking on NodeOS as a somewhat production server, you are likely
building *usersfs* images since each user is isolated of others, but you can be
able to customize all layers. For example, you could be able to modify *rootfs*
to craft a single-user environment or also dedicate a full NodeOS instance to a
single application.


# Build NodeOS for QEmu from scratch in three steps

Requires genext2fs. Install with `sudo apt-get install genext2fs`

1. Download the project source code and build NodeOS for QEmu.

    ```bash
    git clone git@github.com:NodeOS/NodeOS.git
    cd NodeOS
    PLATFORM=qemu_32 npm install
    ```
To build for 64 bits, use `PLATFORM=qemu_64 npm install`

2. Pick some microwave pop-corn and go to see a movie. No, really, do it.
3. Exec your fresh compiled NodeOS image

    ```bash
    npm start
    ```

If you encounter an error when building NodeOS, take a look at [this page](https://github.com/NodeOS/NodeOS/wiki/Fixing-NodeOS-Build-Errors)

# NodeOS on Docker

There are some NodeOS images on Docker Hub, but they can be outdated, so it's
recomended to build from source code.

## Quick Start

1. [Install Docker](http://docs.docker.io/en/latest/installation/)
2. One Liner

    ```bash
    sudo docker run -t -i nodeos/nodeos
    ```

or learn how to make a [Custom Build](http://node-os.com/blog/get-involved/)

## Build from Source

*Warning*: the build process is hairy, it probably won't work the first time.
I'm working on that.

```bash
git clone git@github.com:NodeOS/Docker-NodeOS.git
cd Docker-NodeOS
./build
```
