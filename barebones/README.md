# NodeOS barebones

The included script download and compile
[coreutils](http://www.gnu.org/software/coreutils) (needed for
```/usr/bin/env```), [Node.js](http://nodejs.org) and all its required shared
libraries needed to boots to a Node.js [REPL](http://nodejs.org/api/repl.html)
prompt. ```coreutils``` requires some extra build tools, you can install them on
Ubuntu by executing:

```sh
  sudo apt-get install autopoint bison gperf texinfo
```

Executables written in Node should always use as *shebang* `#!/usr/bin/env node`
rather than hard-code the executable path to `/usr/local/bin/node` or
`/usr/bin/node`.
