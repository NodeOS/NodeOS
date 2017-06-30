<!---
NodeOS

Copyright (c) 2013-2017 Jacob Groundwater, Jesús Leganés-Combarro 'piranna' and
other contributors

MIT License
-->

[![Build Status](https://semaphoreapp.com/api/v1/projects/71d72807-779a-40d3-a8d4-523cd0a52eb3/356164/shields_badge.svg)](https://semaphoreapp.com/nodeos/nodeos)
[![Stories in Ready](https://badge.waffle.io/NodeOS/NodeOS.png?label=ready&title=Ready)](https://waffle.io/NodeOS/NodeOS)
[![Join the chat at https://gitter.im/NodeOS/NodeOS](https://badges.gitter.im/NodeOS/NodeOS.svg)](https://gitter.im/NodeOS/NodeOS?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![bitHound Overall Score](https://www.bithound.io/github/NodeOS/NodeOS/badges/score.svg)](https://www.bithound.io/github/NodeOS/NodeOS)
[![MIT Licence](https://badges.frapsoft.com/os/mit/mit.svg)](https://opensource.org/licenses/mit-license.php)   

# NodeOS

[![Greenkeeper badge](https://badges.greenkeeper.io/NodeOS/NodeOS.svg)](https://greenkeeper.io/)

Lightweight operating system using [Node.js](http://nodejs.org) as userspace.

NodeOS is an operating system built entirely in Javascript and managed by
[npm](https://www.npmjs.com). Any package in `npm` is a NodeOS package, that
means a selection of more than 400.000 packages. The goal of NodeOS is to
provide just enough to let `npm` provide the rest. Since anyone can contribute
to it, anyone can create NodeOS packages.

This project won the Spanish [9th National Free Software Championship](https://www.concursosoftwarelibre.org/1415)
on the Systems category and was Honorable Mention of its [10th edition](https://www.concursosoftwarelibre.org/1516).
It was also presented as the degree thesis of [Jesús Leganes Combarro](https://github.com/piranna)
with a qualification of 10/10 with distinction.

## Useful links

* [New Wiki (under work)](https://nodeos.gitbooks.io/nodeos)
* [pre-build releases images](https://github.com/NodeOS/NodeOS/releases)
* [1.0 Roadmap](https://github.com/NodeOS/NodeOS/issues/37)
* [2.0 Roadmap](https://github.com/NodeOS/NodeOS/issues/146)
* [media files](https://github.com/NodeOS/media) (logos, wallpapers...)
* [discussion](https://github.com/NodeOS/NodeOS/issues)

[![Join the Discussion](http://i.imgur.com/hUjSLXt.png)](https://github.com/NodeOS/NodeOS/issues)

## Introduction

NodeOS is a Node.js based operating system, built-off of the Linux kernel. The
NodeOS Project is aiming to, and can already run on some of the following
platforms:

- **real hardware** like desktops, laptops, or SoC's (Raspberry Pi)
- **cloud providers** like Joyent, Amazon or Rackspace
- **virtual machines** like QEmu, VirtualBox, VMWare and KVM
- **PaaS providers** like Heroku or Joyent's Manta
- **container providers** like Docker & Vagga

Core development is being done in layers. There could be some differences to
adjust better to each target platform, but the general structure is:

- *barebones* custom Linux kernel with an initramfs that boots to a Node.js REPL
- *initramfs* Initram environment to mount the users partition & boot the system
- *usersfs*   multi-user environment with the same behaviour of traditional OSes

### Booting process

All the layers are bootable, leading *barebones* to a raw naked Node.js
[REPL](http://nodejs.org/api/repl.html) prompt as PID 1, while *initramfs* exec
actual NodeOS code to isolate user code from the core system and, if available,
mount a partition  with the users' home directories and root filesystems.

If a *usersfs* partition is being set at boot time, it will be mounted and the
system will consider each one of its folders as the home folder for a valid user
on the system, and will execute a `init` file in the root of each of them. If
found, the `root` user will be the first to be considered and will have access
to all of the home directories, but by design it will not be possible to elevate
permissions once the system has finished booting.

### Hacking

If you are hacking on NodeOS for a somewhat production environment, you are
likely interested on building a custom *usersfs* image or modify it once booted,
since each user is isolated from the others and everyone can be able to define
its own root filesystem, but you can customize all other layers if you want. For
example, you can modify *initramfs* to login users and mount their home folders
from a cloud service or craft a system without global services (no `root` user),
or also dedicate a full NodeOS instance to a single Node.js application.


## Pre-built Images

Ready to use [pre-build images](https://github.com/NodeOS/NodeOS/releases) are
automatically generated after each commit in master branch that sucessfully
[pass the tests](https://semaphoreapp.com/nodeos/nodeos). To exec them, you'll
need to have [QEmu](http://wiki.qemu.org/Main_Page) installed on your system.

The *iso* can be written to a CD-R or flashed to a USB pendrive, but will only
provide the read-only rootfs and the changes will be done in memory, losing them
after reboot, so you'll manually need to set a read-write *usersfs* partition if
you want to persist them. On the other hand, if you want to flash it to a USB
pendrive, We recommended doing it by using `bin/installUSB` command so it will
automatically create a read-write *usersfs* partition to fill the remaining
space and use it as persistent storage.

## Build NodeOS in five steps

1. Download the project source code:

   ```bash
   git clone git@github.com:NodeOS/NodeOS.git
   cd NodeOS
   ```

2. Install the required build tools. On a Ubuntu based system you can do it by
   executing:

   ```bash
   sudo bin/install-dependencies
   ```

3. Install NodeOS build dependencies:

   ```bash
   npm install
   ```

4. Build NodeOS:

    ```bash
    npm run build
    ```

   By default it will generate some files that can be used with QEmu, compiled
   for your current machine architecture. You can  configure the build process
   by passing some environment variables. For example, to force to build for 32
   bits, use `BITS=32 npm install` instead.

5. Exec your freshly compiled NodeOS image:

   ```bash
   npm start
   ```

   It will automatically detect what CPU architecture will need to be used on
   QEmu and exec the correct emulation.

...profit! :-D

If you encounter an error when building NodeOS, take a look at
[the wiki](https://github.com/NodeOS/NodeOS/wiki/Fixing-NodeOS-Build-Errors) or
open an [issue](https://github.com/NodeOS/NodeOS/issues).

## Single Process OS

NodeOS can be used as a Single Process OS, where only run a single executable.
To do so, set the `SINGLE_USER` environment variable to the name of a `npm`
module when executing `npm run build`. This will run fully from initram,
persistence can be achieved by setting this environment variable to an empty
string and later using a custom `usersfs` partition, but this is still
experimental.

## NodeOS on LXC containers (Docker and vagga)

NodeOS fully officially supports Docker, published images are available at the
[DockerHub NodeOS organization](https://hub.docker.com/u/nodeos). If you are
interested in helping or testing, you can build them from source code.

Vagga support is fairly experimental, and help here will be greatly appreciated.

### Quick Start

1. [Install Docker](http://docs.docker.io/en/latest/installation/)
2. One Liner

   ```bash
   sudo docker run -t -i nodeos/nodeos
   ```

### Build from Source

```bash
git clone https://github.com/NodeOS/NodeOS.git
cd NodeOS
PLATFORM=docker npm install
```

## License

MIT

This software consists of voluntary contributions made by many individuals. For
exact contribution history, see the revision history available at
https://github.com/NodeOS/NodeOS
