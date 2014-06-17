The `npkg` command is the *one command to rule them all*.
It's mostly a convenience.
We want a single command for

1. installing and removing commands
2. installing and removing services
2. starting and stopping services
3. configuring services

These are reflected in the commands

```bash
npkg [install|uninstall] <PKG>
npkg [start|stop] <PKG>
npkg config
```
