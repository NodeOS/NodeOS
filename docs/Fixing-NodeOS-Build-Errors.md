
> scripts/install: line 93: genext2fs: command not found

You need to install genext2fs: `sudo apt-get install genext2fs`

> can not find a C compiler

The build probably got closed while in progress.  Delete the `out` and `obj` folders you find in the sub folders of `node_modules`

> scripts/start
Could not access KVM kernel module: No such file or directory
failed to initialize KVM: No such file or directory

Your computer or virtual machine doesn't support kvm.  Comment out [this line](https://github.com/NodeOS/NodeOS/blob/master/scripts/start#L34)

> /usr/bin/env: node: No such file or directory

Try 
```
sudo apt-get update      
sudo apt-get dist-upgrade
```

If you have any other errors when building NodeOS, check if there is an issue for the error.  If there isn't please create [a new issue](https://github.com/NodeOS/NodeOS/issues/new).