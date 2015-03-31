# NodeOS initramfs

This package generate a initramfs image that will try to mount the users
filesystem, set on the *root=* flag on Linux command line. If it fails to do so,
it boots to a Node.js [REPL](http://nodejs.org/api/repl.html) prompt using an
on-memory root filesystem.

## Note about *env.js*

Since ```/usr/bin/env``` is also a Node.js script, to use less memory and boot
faster it's checking that the script to be run is already a Node.js script and
if so, it ```require()```s it and exec it directly to re-use the current Node.js
instance. This has the drawback that Python-inspired tricks like
```!module.parent``` or ```require.main === module``` will not work anymore. A
better alternative and currently more widely used when a package can be used
both as a library and as an executable is to define the executable at an
independent script file and use the ```package.json``` *main* and *bin* entries.
