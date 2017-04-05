The root user is like any other [user directory](FileSystem#user-directories)
but it's also in charge of booting the system.

```
/root/
  bin/
    init     <-- boots the system
    asgard   <-- service manager started by init
  lib/       <-- installed node_modules for init/asgard
  log/       <-- log files from init and other root services
  var/       <-- persistent data for root services
```

The root directory at minimum needs the above, but will likely contain other modules helpful to booting the system.

## the kernel and init

During boot after the kernel has loaded,
it passes control to another process typically called the *init process*.
The init process has PID 1, and *must* start the rest of the system.
If init fails to boot the rest of the system,
the kernel either panics or your box does nothing interesting.

Typically on Linux init is located at `/sbin/init`.
In you don't specify where your init process is,
the kernel will automatically look in that spot.
During boot however any other process can be booted as your PID 1.
This is done by passing the kernel an `INIT=<path>` argument on startup.

On node-os there is no process at `/sbin/init`.
Instead our init command is simply an executable installed to `/root/bin/`.
Init is a node module, with a `bin` key in it's `package.json` file.
Any node module can be the node-os init,
but we try to provide a very useful, but minimal, init module.
