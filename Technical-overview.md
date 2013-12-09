## File System

**Layout**
```text
/bin/
  node <--------------- node binary
  npkg <--------------- npkg is globally intalled
/lib/  <--------------- shared libraries required by node
  node_modules/ <------ a few fundamental modules are globally installed
    bin-npkg/
    npm
/usr/lib/ <------------ other shared libs required by node
/root/ <--------------- root users $HOME directory
  bin/ <--------------- binaries exposed by node modules in $HOME/lib/node_modules
    init
    nsh
  lib/
    node_modules/ <---- modules installed by npkg go here
      bin-nsh
      bin-fs
      bin-init
```

## The Root User

You've very likely logged in as the root user:

- your `$HOME` is set to `/root`
- your `$PATH` is set to `$HOME/bin:/bin`

## Using `npkg` to install modules

The `npkg` command *always* installs modules relative to the current user.

- modules are installed to `$HOME/lib/node_modules`
- executables are placed in `$HOME/bin`

