# NodeOS on Docker

- Please first [Install Docker](http://docs.docker.io/en/latest/installation/vagrant/)

## Quick Start

```
git clone https://gist.github.com/6757451.git NodeOS
sudo docker build -t MyOS NodeOS
sudo docker run -t -i MyOS
```

## Introduction

NodeOS is a Node.js based operating system, built off of the Linux kernel.
The eventual goal of NodeOS is to produce images that can be run on 

- hardware
- cloud providers like Joyent/Amazon/Rackspace
- local virtual machines, like VirtualBox, VMWare, and KVM
- container providers, like Docker

Core development is being done in layers, facilitated by Docker.

- Layer-0 provides the boot loader and kernel (currently provided by Docker)
- Layer-1 provides the Linux shared libraries
- Layer-2 provides the Node.js binary
- Layer-3 provides the core NodeOS additions, like the init daemon and package manager
- Layer-4 is for customizing distributions

If you are hacking on NodeOS, you are likely building Layer-4 images.
Layer-4 images can be build entirely from a `Dockerfile`,
where as the other layers require more finesse.

## Build from Source

```
git clone git@github.com:NodeOS/Docker-NodeOS.git
cd Docker-NodeOS && git submodule init
./build
```
