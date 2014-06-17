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

## installing packages

Packages installed with `npkg install` are installed to `$HOME/lib/node_modules`,
and any executables defined in the package are linked into `$HOME/bin`.
Since `npkg` always writes to your home directory,
you do not need root permissions.

You can use `npkg install` to craft a custom interface to the systme,
unique to every user.

```bash
$ ncurl google.com
  ERROR ncurl not found
$ npkg install ncurl
  --> installing ncurl from npmjs.org
  --> okay, done
$ ncurl google.com
<!DOCTYPE html>
...
```

## staring services

Packages installed with `npkg install` can also be **services**.
A module defines a service by specifying a `scripts:start` key in it's `package.json` file.


```json
{
  "name": "my_app",
  "scripts": {
    "start": "node server.js"
  }
}
```

You can one-step daemonize this module with

```bash
$ npkg start my_app
```
