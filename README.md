# NodeOS

## State of the Union

- the latest alpha is build up using [Docker layers](https://github.com/NodeOS/Docker-NodeOS)
- start here `git clone https://gist.github.com/6757451.git NodeOS`
- current milestone is complete the docker release pipeline
- next milestone is to complete `init` and `npkg`

## Introduction

NodeOS is an OS only by the following definition:

```
+-----------+
| Hardware  |
+-----------+
| Kernel    |
+-----------+
| Root      | <---  Where NodeOS lives
+-----------+
| Userland  |
+-----------+
```

1. NodeOS is *not* a NodeJS kernel
2. NodeOS starts *after* the kernel loads
3. No non-kernel processes run before NodeOS

For the purposes of this project, the above definition is *always* what is meant by an OS.
One consequence of this definition is that eventually, NodeOS might be kernel agnostic.

## Goal

- The primary goal of NodeOS is to provide a working package manager
- The primary package manager will use NPM
