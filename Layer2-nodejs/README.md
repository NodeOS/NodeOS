# NodeOS Docker Layer-2 Image

```
sudo name=layer2 ./build 
```

Layer-2 contains only the Node.js binary.
Given the importance of Node.js on the system, it is placed at `/bin/node`.
Executables written in Node should use *shebang* `#!/usr/bin/env node` always,
rather than hard-code the executable path to `/usr/local/bin/node` or `/usr/bin/node`.

- Layer-2 builds Node.js from source.
