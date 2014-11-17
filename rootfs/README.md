# NodeOS rootfs

The included script creates a disk image with the packages needed to offer some
basic functionality and load the users filesystem, and install gcc and its
shared libraries.

If it's not given a USERS parameter pointing to a *usersfs* partition on boot
time, it boots to a Node.js [REPL](http://nodejs.org/api/repl.html) prompt. To
fill the disk image without ```sudo``` it's needed to use genext2fs. You can
install it on Ubuntu by executing:

```sh
  sudo apt-get install genext2fs
```

NodeOS is incredibly lean, leaving most of the system configuration up to the
installed packages.
