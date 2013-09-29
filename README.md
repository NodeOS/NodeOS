# NodeOS on Docker

```
git clone git@github.com:NodeOS/Docker-NodeOS.git
cd Docker-NodeOS && git submodule init
./build
```

NodeOS is a Node.js based operating system, built off of the Linux kernel.
The eventual goal of NodeOS is to produce images that can be run on 

- hardware
- cloud providers like Joyent/Amazon/Rackspace
- local virtual machines, like VirtualBox, VMWare, and KVM
- container providers, like Docker

Core development is being done in layers, facilitated by Docker.

- Layer-0 provides the boot loader and kernel (currently provided by Docker)
- Layer-1 provides the Linux shared libraries for Docker
- Layer-2 provides the Node.js binary
- Layer-3 provides the core NodeOS additions, like the init daemon and package manager
- Layer-4 is for customizing distributions

If you are hacking on NodeOS, you are likely building Layer-4 images.
Layer-4 images can be build entirely from a `Dockerfile`,
where as the previous images require more finesse.

