**Note: This document has not yet been revised.**
# Building From Source

## Step 1: Prerequisites

- **Git**. To install using:

  - for **Debian/Ubuntu**: `apt-get install git`
  - for **Arch**: `pacman -S git`

- Node 4.x
- NPM 2.x

**_Note: If you're using Node 5.x and NPM 3.x, the build process will crash, further Information under [[Troubleshooting]] or Issue #218_**

After you installed the prerequisites just clone the repository

```bash
$ git clone https://github.com/NodeOS/NodeOS.git
```

## Step 2 (Debian/Ubuntu): Dependencies

Once you've installed the prerequisites you need the dependencies for Debian/Ubuntu using `apt-get`. First you need to update your cache. To do so run

```bash
$ dpkg --add-architecture i386
$ apt-get -qq -y update
```

Then you install the dependencies listed below

- cross compiler dependencies: `apt-get -qq -y gcc g++ realpath texinfo`
- barebones dependencies: `apt-get -qq -y bc libpixman-1-dev`
- rootfs dependencies: `apt-get -qq -y genisoimage libuuid:i386`
- userfs dependencies: `apt-get -qq -y autoconf automake`
- qemu dependencies: `apt-get -qq -y libsdl1.2-dev`

Or as a one liner:

```bash
$ apt-get -qq -y gcc g++ realpath texinfo bc libpixman-1-dev genisoimage libuuid:i386 autoconf automake libsdl1.2-dev
```

Or just run if you're outside the folder

```bash
$ cd NodeOS/
$ bin/install-debian-deps
```

## Step 2 (Arch Linux): Dependencies

Once you have installed the prerequisites you need the dependencies for Arch Linux

- cross compiler dependencies: `pacman -S gcc texinfo python2`
- barebones dependencies: `pacman -S bc pixman lib32-pixman`
- rootfs dependencies: `pacman -S cdrkit`
- initramfs dependencies: `pacman -S cpio`
- userfs dependencies: `pacman -S autoconf automake`
- qemu dependencies: `pacman -S sdl`

**_Note: The initramfs dependencies are not shipped with the installation of Arch Linux thats why we need to install them on Arch Linux_**

Or as one liner:

```bash
$ pacman -S gcc texinfo python2 bc pixman lib32-pixman cdrkit cpio autoconf automake sdl
```

Or just run if you're outside the folder

```bash
$ cd NodeOS/
$ bin/install-arch-deps
```

## Step 3: Installation

Once you've installed the correct dependencies for your operating system you can start with the installation of NodeOS.

**_Note: If you have Arch Linux you need to set python2 as default binary when you run `python`. Because the standard python binary is python3 and nodegyp doesn't uses it._** To do this, run following commands:

```bash
$ cd /usr/bin
$ ln -sf python2 python
```

The next step is to install the npm dependencies and the bundled dependencies to do this run following command:

```bash
$ npm install
```

If you want to change the target platform to build NodeOS for, just prepend the `PLATFORM` argument before `npm install`. Example (NodeOS for QEMU 32bit):

```bash
$ PLATFORM=qemu_32 npm install
or
$ PLATFORM=docker npm install
```

Now it should install correctly. This process can take some time, so pick some microwave pop-corn and go to see a movie. No, really... do it.

## Step 4: Run your fresh NodeOS build

Now you can run your fresh build with:

```bash
$ npm start
```

If NodeOS does not boot into the REPL, unless you wanted that, then everything was compiled correctly. **If not look under [[Troubleshooting]]**

After NodeOS has booted up you should see something like:

```
Hello! I'm a user init script :-)
```

Now you're prompted to enter your username and password. By default, the username and password is `nodeos` and cannot be changed without altering code.

```
$ username: nodeos
$ password: nodeos
```

**Note: This is not permanent on later versions this will be changed**
