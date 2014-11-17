# NodeOS barebones

The included script download and compile

- [gcc](https://gcc.gnu.org/)
- [coreutils](http://www.gnu.org/software/coreutils)
- [glibc](http://www.gnu.org/software/libc/)
- [Node.js](http://nodejs.org)
- [linux kernel](https://www.kernel.org/)

It can be able to boots to a Node.js [REPL](http://nodejs.org/api/repl.html)
prompt. ```coreutils``` requires some extra build tools, you can install them on
Ubuntu by executing:

```sh
  sudo apt-get install autopoint bison gperf texinfo
```

Executables written in Node should always use as *shebang* `#!/usr/bin/env node`
rather than hard-code the executable path to `/usr/local/bin/node` or
`/usr/bin/node`.
