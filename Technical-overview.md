## File System

**Layout**
```
/bin/
  node <--------------- node binary
/lib/  <--------------- shared libraries required by node
/usr/lib/ <------------ other shared libs required by node
/root/ <--------------- root users $HOME directory
  bin/ <--------------- binaries exposed by node modules in $HOME/lib/node_modules
  lib/
    node_modules/ <---- modules installed by npkg go here
      bin-nsh
      bin-fs
      svc-init
```
