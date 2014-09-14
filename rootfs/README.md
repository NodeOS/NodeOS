# NodeOS rootfs

The included script creates a disk image with the packages needed to offer some
basic functionality and load the users filesystem. If it's not given a USERS
parameter pointing to a *usersfs* partition on boot time, it boots to a Node.js
[REPL](http://nodejs.org/api/repl.html) prompt.

NodeOS is incredibly lean, leaving most of the system configuration up to the installed packages.
