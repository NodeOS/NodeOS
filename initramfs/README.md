# NodeOS initramfs

The included script download and compile [coreutils](http://www.gnu.org/software/coreutils)
(needed for ```/usr/bin/env```), [Node.js](http://nodejs.org) and all its
required shared libraries, and generate a initramfs image that boots to a
Node.js [REPL](http://nodejs.org/api/repl.html) prompt if it's not given a ROOT
parameter pointing to a *rootfs* partition.

Executables written in Node should always use as *shebang* `#!/usr/bin/env node`
rather than hard-code the executable path to `/usr/local/bin/node` or `/usr/bin/node`.
