## _Warning! Deprecated_ in place of [[PalmTree|Service Starter (PalmTree)]] ##
NodeOS now uses PalmTree as it's service manager. But we leave this here for now as it's quite a beautiful page :smile: 

***

The service-manager (code name asgard) is a task running service.

Asgard provides a simple abstraction, upon which a tool like [[npkg]] can build a traditional service manager like *systemd* or *forever*.

Asgard has two abstractions:

1. a **task** is a real process that must be run
2. a **queue** is an ordered list of tasks

This is a low-level abstraction, and not really of concern for the end user. The end-user will use a tool like [[npkg]] and in general never need to know about how asgard works. Similar to how there is no *spawn* system call, rather spawning a child process is just a combination of `fork` and `exec`.

So for anyone who just wants to run your node process, have a look at [[npkg]]. For those interested in the gory details, here are a few high-level features of asgard:

- tasks are run as soon as they are added to a queue
- tasks run sequentially per queue
- different queues run in parallel
- when a queue is empty, it just waits for new tasks to be added
- there is limited support for manipulating a queue

Typically queues will only have a few tasks added to them at any time.

## HTTP IPC

You communicate with asgard over http using JSON encoded data.

For example, to start a queue you `PUT` to `/queue/:name` where `:name` is the unique identifier for your queue.

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
      "fds": [...]
    }
  ]
}
```

The following are optional for each *task*

```javascript
{
  "user"  : 2, // prefer numeric id
  "group" : 3,
}
```

Eventually we would like to support segmenting processes, and limiting them via a quota.
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

HTTP + SSL is secure. If you think otherwise, you should stop using the web. We actually punt on handling security in asgard. Instead, we require that you secure the socket asgard is listening to.

For simple cases, you can bind to `localhost`. Only processes on the same host can access asgard.

A better approach might be binding to a unix domain socket, for example `/root/var/asgard.sock`. You can use file-system permissions to restrict access to the http server. This is how Docker works.


## Permissions

There is no access-control. Either you have access to everything, or nothing.
In a multi-user environment, each user will run their own asgard service.

Since each users copy of asgard runs with user-permissions, not root permissions, it can only do as much damage as the user sending jobs to it.

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

There are no restart semantics. You can restart a queue by defining a second restart task, e.g.

```javascript
{
  tasks: [
    {...}, // queue to run
    {...}  // command to restart queue
  ]
}
```

The second command can decide how to restart the service,
since different tasks will demand different restart semantics.

Why restart semantics are difficult:

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
- asgard is focused on running tasks, and queues.
- asgard should export a well-defined API, to allow multiple products interact with it.
