The service-manager (code name asgard) is a job-control service.

## HTTP IPC

You communicate with asgard over http.

For example, to start a job you `PUT` to `/job/:name` where `:name` is the unique identifier for your job.

```json
{
  "tasks": [
    {
      "exec": "node",
      "args": ["server.js"],
      "envs": {
        "PATH": "/bin:/root/lib/node_modules/myapp/node_modules/.bin"
      },
      "cwd": "/root/lib/node_modules/myapp",
      "fd": []
    }
  ]
}
```

The following are optional for each *task*

```javascript
{
  "exec": ...

  "user"  : 2, // prefer numeric id
  "group" : 3,
}
```

The following are reserved, but not implemented.
For more information see the Linux [clone](http://linux.die.net/man/2/clone) call.

**these are a draft**

```javascript
{
  "limit" : {
    "memory" : "1GB",
    "cpu"    : "50%"
  },
  "mount": { // create a new mount namespace
    // TBD
  },
  "iface": { // create a new network namespace
    // TBD
  },
  "newpid": true, // create a new PID space
  "newpic": true, // create a new PIC space
}
```

All of the above are required, aside from `user` and `group`.

## File Descriptors

File descriptors are pointers to various IO conduits of a process. There are many *things* that can be represented by a file descriptor,

- a normal file on the file system
- an unnamed pipe between two processes
- a named pipe
- a network socket
- a unix domain socket
- a block or character device

Each of the above is represented by a file-descriptor, and various system calls can be made to each descriptor based on the *thing* it represents.

Going forward, we probably want asgard to work with *all* of the above.

```javascript
{ // a file
  type: "file",
  path: "/root/docs/myfile.txt",
  mode: "rw",
}

{ // a unix socket
  type: "unix socket",
  path: "/root/var/myapp.sock"
}

{ // a network socket
  type: "network socket",
  bind: "127.0.0.1",
  port: 8080
}

{ // a named pipe
  type: "named pipe",
  path: "..."
}
```

I don't want to support all of these yet, but it's something to keep in mind. I'm also not sure how to represent unnamed pipes between processes.

Asgard should respond with `501 Not Implemented`, rather than a `400/500` error when using an unsupported file type.

## Authentication

HTTP is secure. If you think otherwise, you should stop using all websites.

HTTP security can be poorly implemented however. We actually punt on handling security asgard the server. Instead, we require that you secure the socket.

For simple cases, you can bind to `localhost`. Only processes on the same host can access asgard.

A better approach might be binding to a unix domain socket, for example `/root/var/asgard.sock`. You can use file-system permissions to restrict access to the http server. This is how Docker works.


## Permissions

There are no permissions. Either you have access to everything, or nothing.

> Each copy of init spawns jobs requested by a particular user, so that user needs access to all jobs supervised by a single init process. We however don't want jobs to have access to each other. If jobs are spawned under the current user, then jobs will be able to call init on behalf of the user.
>
> On linux, the clone system call governs all new process (and thread) creation. Clone lets you decide what to share, and what not to share. If we require that all modules must contain all their dependencies, we could isolate each service in its own file system. This would cut the service off from having access to init.
>
> -[Jacob June 18](https://github.com/NodeOS/node-init/issues/3#issuecomment-46272433)

In a multi-user environment, each user will run their own asgard service.

```
-+ asgard (root)
  \
   +-+ asgard (bob)
   |  \
   |   server.js (bob's server)
   |
   +-+ asgard (tom)
      \
       server.js (tom's server)
```

## Restart Semantics

There are no restart semantics. You can restart a job by defining a second restart task, e.g.

```javascript
{
  tasks: [
    {...}, // job to run
    {...}  // command to restart job
  ]
}
```

Restart semantics are difficult

- A process that exits immediately due to an error can peg the CPU at 100%.
- Generally we do not want to ever *stop* trying to restart a process.
  Do you care more if your CPU gets pegged for a while, or your website goes down?
- Sometimes we want notifications when processes exit.

We let the caller to asgard decide how they want to handle restart.

- Tasks are always run serially.
  The previous task always exist before the next one starts.
- The exit code of the previous process is available via the
  environment variable `TASK_EXIT`.
  This will either be the number or signal name that
  caused the previous task to exit.

## Review

- asgard is simple, yet flexible.
- asgard is focused on running tasks, and jobs.
- asgard should export a well-defined API, to allow multiple products interact with it.
