# node-os

## State of the Union

- [node-os.com](http://node-os.com)
- [quick start tutorial](http://node-os.com/blog/get-involved)
- [build from source with docker](https://github.com/NodeOS/Docker-NodeOS)
- [view packages for node-os on npkg.org](http://npkg.org)

## introduction

what is node-os?

```
+-----------+
| hardware  |
+-----------+
| kernel    |
+-----------+
| root      | <---  this piece is node-os
+-----------+
| userland  |
+-----------+
```

## node-os uses npm

We want to bring npm to the entire system.
Any package in npm is a node-os package,
which at last count was 56,594 packages.
The goal of node-os is to provide just enough to let npm provide the rest.
Since anyone can contribute to npm, anyone can create node-os packages.
