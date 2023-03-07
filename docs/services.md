Services are long-running processes that provide utility to the system.
Common services you might find on a Linux system are

- `sshd` for ssh access
- `dhcpd` to set the IP address at boot
- `getty` for connecting the console to a login session
- `ntpd` for setting the time from the network

These services are generally *automated* and *long running*.
Let's itemize the actual requirements of a service.

1. services can be started at boot automatically
2. services should make an effort to retry on failure
3. users should be able to start services at runtime
4. services should survive a user logging out

The above are standard for almost every service manager today.
Typically [[init]] or another service manager handles system services.

- Mac OS X uses `launchd`
- Ubuntu uses `upstard`
- RHEL uses `systemd`
- Windows uses ?
- SmartOS uses `SMF`

NodeOS uses PalmTree as it's service starter. You can read more about working with it here on the wiki (see [[Service Starter|Service Starter (PalmTree)]]) and explore it's [repository](https://github.org/lite20/palmtree) too.