# node-os

## State of the Union

- the latest alpha is build up using [Docker layers](https://github.com/NodeOS/Docker-NodeOS)
- start here `git clone https://gist.github.com/6757451.git NodeOS`
- current milestone is to complete the docker release pipeline
- next milestone is to complete `init` and `npkg`
- core packages are itemized at [npkg.org](http://npkg.org)

## Introduction

node-os is an OS only by the following definition:

```
+-----------+
| Hardware  |
+-----------+
| Kernel    |
+-----------+
| Root      | <---  Where node-os lives
+-----------+
| Userland  |
+-----------+
```

1. node-os is *not* a node.js kernel
2. node-os starts *after* the kernel loads
3. No non-kernel processes run before node-os

For the purposes of this project, the above definition is *always* what is meant by an OS.
One consequence of this definition is that eventually, node-os might be kernel agnostic.

## Goal

- The primary goal of node-os is to provide a working package manager
- The primary package manager will use NPM
