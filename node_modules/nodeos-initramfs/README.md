# NodeOS initramfs

This package generate a initramfs image that will try to mount the users
filesystem, set on the *root=* flag on Linux command line. If it fails to do so,
it boots to a Node.js [REPL](http://nodejs.org/api/repl.html) prompt using an
on-memory root filesystem.
