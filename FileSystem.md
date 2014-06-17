## system directories

The base filesystem is laid out as follows.

A few standard linux directories are now considered private,
and only included for compatibility with the current *libc*.

```
/bin   <-- contains latest node executable
/lib
/usr
/etc
```

All user-editable content should be in user-directories.
The root user's home is in it's standard `/root` location.

```
/root  <-- root user
/home  <-- non-root users
```

The [[root]] user is special because it boots the system.

Other standard kernel-provided file systems are mounted in their usual locations.

```
/dev   <-- devfs
/proc  <-- procfs
/sys   <-- sysfs
/tmp   <-- tmpfs
```

## user directories

There are no *global* services, modules, or commands.
Directories that were once system-leve, like `etc`, and `var` are now user-local.

```
$HOME/
  bin/             <-- executable commands
    ls, cp, mv
  lib/
    node_modules/  <-- modules installed by npkg
  log/             <-- logs from init jobs
  etc/             <-- configuration files
  var/             <-- persistent data
  tmp/             <-- ephemeral data
```

In detail:

- `bin` contains executable commands, linked during `npkg install`.
- `lib` contains `node_modules` which holds modules installed by `npkg`.
- `log` contains output from services and jobs.
- `etc` contains local config values for services and jobs
- `var` holds persistent data for services and jobs.
- `tmp` holds ephemeral data for services and jobs.

These directories are used assumed by the `npkg` command.
