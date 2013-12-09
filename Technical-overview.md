The base NodeOS install provides only enough to let `npkg` take over.
Everything else can be provided as a node module distributed through `npm`.
There is no attempt to version manage `node` via `nvm`, `nave`, or a similar tool.
NodeOS will always assume you are using the latest stable version of node.
If a package is incompatible with the latest node version, you should fix the broken package.

## File System

**Layout**
```text
/bin/
  node <--------------- node binary
/lib/  <--------------- shared libraries required by node
/usr/lib/ <------------ other shared libs required by node
/root/ <--------------- root users $HOME directory
  bin/ <--------------- binaries exposed by node modules in $HOME/lib/node_modules
    npkg
    init
    nsh
  lib/
    node_modules/ <---- modules installed by npkg go here
      bin-npkg
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
