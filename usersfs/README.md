# NodeOS usersfs

The included script creates a disk image with a basic user with some
pre-installed packages and npm. To fill the disk image without ```sudo``` it's
needed to use genext2fs. You can install them on Ubuntu by executing:

```sh
  sudo apt-get install genext2fs
```

NodeOS is incredibly lean, leaving most of the system configuration up to the installed packages.
