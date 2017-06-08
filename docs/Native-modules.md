Native modules require compilation via a `gypfile`.
NodeOS comes with no build environment, and it may be quite a while before one exists.

Despite a lack of build tools, NodeOS could not function without native dependencies.
Node has no native way to set an IP address, or configure the network gateway.
Node cannot mount file systems, or issue reboot commands.
Many system calls are not exposed natively by node, and as such require a native module interface.

Some compiled modules required by NodeOS

- src-sockios
- src-ioctl
- src-mount

Until npm supports delivering pre-compiled dependencies, NodeOS will need a workaround.
The workaround is currently under development.
