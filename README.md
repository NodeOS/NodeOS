[![Build Status](https://semaphoreapp.com/api/v1/projects/71d72807-779a-40d3-a8d4-523cd0a52eb3/356164/shields_badge.svg)](https://semaphoreapp.com/nodeos/nodeos)
[![Stories in Ready](https://badge.waffle.io/NodeOS/NodeOS.png?label=ready&title=Ready)](https://waffle.io/NodeOS/NodeOS)
# NodeOS

Lightweight operating system using [Node.js](http://nodejs.org) as userspace.

NodeOS is an operating system build entirely in Javascript and managed by
[npm](https://www.npmjs.com/). Any package in npm is a NodeOS package, which at
last count was 134,872 packages. The goal of NodeOS is to provide just enough to
let npm provide the rest. Since anyone can contribute to npm, anyone can create
NodeOS packages.

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
- *initramfs* Initram environment to mount the users partition & root filesystem
- *rootfs*    Read-only partition image to host Linux kernel and initramfs files
- *usersfs*   multi-user environment with the same behaviour of traditional OSes

### Booting process

All the layers are bootable, leading *barebones* to a Node.js
[REPL](http://nodejs.org/api/repl.html) prompt. *initramfs* (and by extension
*rootfs*) lead to a Node.js REPL by default if not using a custom one. In all
the cases, it will be used an initramfs as root filesystem and all the changes
will be lost when powered-off.

If a users partition is being set at boot time, it will be mounted and the
system will considerate each one of the folders there as the home folder for a
valid user on the system and executing a ```init``` file in the root of each of
them. If found, ```root``` user will be the first to be considerated and will
have access to all the home directories.

### Hacking

If you are hacking on NodeOS as a somewhat production server, you are likely
building *usersfs* images since each user is isolated of others, but you can be
able to customize all layers. For example, you could be able to modify
*initramfs* to login the users and mount their home folders from a cloud service
or craft a system without global services (no ```root``` user) or also dedicate
a full NodeOS instance to a single application.


# Build NodeOS in three steps

NodeOS require to have first installed some build tools, on a Ubuntu based
system you can install them by executing the file ```install-dependencies.sh```.

1. Download the project source code and build NodeOS for QEmu:

    ```bash
    git clone git@github.com:NodeOS/NodeOS.git
    cd NodeOS
    npm install
    ```
By default it generate some files that can be used with QEmu, compiled for your
current architecture. You can be able to configure the build process by passing
some environment variables. For example, to force to build for 32 bits, use
```PLATFORM=qemu_32 npm install``` instead.

2. Pick some microwave pop-corn and go to see a movie. No, really, do it.
3. Exec your fresh compiled NodeOS image:

    ```bash
    npm start
    ```
It will automatically detect what CPU architecture will need to be used on QEmu.

...and profit! :-D

If you encounter an error when building NodeOS, take a look at
[the wiki](https://github.com/NodeOS/NodeOS/wiki/Fixing-NodeOS-Build-Errors) or
open an [issue](https://github.com/NodeOS/NodeOS/issues).

# NodeOS on Docker

Currently Docker support is unmaintained. There are some NodeOS images on Docker
Hub, but they are outdated. If you are interested on help or testing, you can
build them from source code.

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
git clone git@github.com:NodeOS/NodeOS.git
cd NodeOS
PLATFORM=docker npm install
```
