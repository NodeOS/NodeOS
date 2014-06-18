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

You can use `npkg install` to craft a custom command line interface unique to every user.
For example:

Install a package from *npm* which includes a [bin key](https://github.com/groundwater/node-bin-ifconfig/blob/master/package.json#L12-L14).

```bash
$ npkg install bin-ifconfig
  --> installing bin-ifconfig from npmjs.org
  --> linked executable `ifconfig`
```

Executables are installed to `$HOME/bin`, and should be immediately available to the CLI.

```bash
$ ifconfig
{
  "lo0": { ip: "127.0.0.1", mask: "255.255.255.0" }
}
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
