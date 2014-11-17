# NodeOS initramfs

The included script generate a initramfs image that boots a NodeOS rootfs given
as a ROOT parameter on boot time. If it fails to do so, it boots to a Node.js
[REPL](http://nodejs.org/api/repl.html) prompt.

Executables written in Node should always use as *shebang* `#!/usr/bin/env node`
rather than hard-code the executable path to `/usr/local/bin/node` or
`/usr/bin/node`.
