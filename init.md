Init *will* be a super-simple process.

1. periodically reap dead children
2. start the root service manager [[asgard]]

## zombies

The way Linux works,
when a parent process dies it's children become children of PID 1.
When those children exit,
their PID number and exit status are recorded in the kernels process table.
The parent, in this case init,
needs to periodically call `wait` or `waitpid` to clear the process table.
Processes which have exited but have not been cleared are called **zombies**.

You don't want too many zombies.

Init will inherit a lot of children,
and when they die it needs to stop the zombie apocalypse.

## service manager

We want to keep init simple.
Once init is up and ready to be the grim reaper,
it needs to pass control to someone else.

The service manager [[asgard]] is what launches all the interesting processes on the system.
