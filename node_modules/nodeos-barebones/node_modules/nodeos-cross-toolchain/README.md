# NodeOS cross toolchain

This package generate a cross-compiler based on [gcc](https://gcc.gnu.org/) and
[musl](musl-libc.org) ready to use on the NodeOS build system, but could be used
by other systems. You can be able to configure the target of the cross-compiler
by setting some optional environment variables:

- **PLATFORM**: by default it will generate for the current system
- **CPU**: by default it will generate for the current CPU
