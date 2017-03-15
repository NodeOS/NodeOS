<!---
NodeOS

Copyright (c) 2013-2017 Jacob Groundwater, Jesús Leganés-Combarro 'piranna' and
other contributors

MIT License
-->

# NodeOS
This zip file host a pre-build NodeOS instance with a demo users filesystem, you
can find info about how to build your own users filesystem at
[NodeOS-usersfs](node_modules/nodeos-usersfs/README.md) package.

## Getting started
This pre-build requires [QEmu](http://wiki.qemu.org/Main_Page).
Please make sure that it's installed.

To run this demo, simply exec the ```run.sh``` script in the root directory.

You should be greeted by the NodeOS-usersfs.
It will ask you for a username and a password.
```
$ username: nodeos
$ password: nodeos
```
If you run into trouble, please checkout the [troubleshooting here](https://github.com/NodeOS/NodeOS/wiki/Troubleshooting)

## Burning to CD or USB
This is the  ISO release, so it can be burned to a CD-R or a USB flashdrive.
However it will run as readonly which means everything is handled in memory and it will be
lost on shutdown.

You can use the script `installUSB`, which will automatically create a read/write filesystem.
You must provide the script with the device to write to, the rootfs and the usersfs files.

*Tip: run the script with no arguments for the usage*

The script will use the remaining space on the USB drive for the filesystem.

## What now?
When you have NodeOS up and running you should take a look at the [commands](https://github.com/NodeOS/NodeOS/wiki/Commands)
