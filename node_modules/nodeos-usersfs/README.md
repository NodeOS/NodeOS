# NodeOS usersfs

This package generates a read-write users filesystem for NodeOS for demo
purposses. It has a *root* user (used to initialize some sub-systems) and a
logable *nodeos* user with some basic pre-installed packages like a shell
([nsh](https://github.com/groundwater/node-bin-nsh)) and some basic tools and
demo commands. You can login using password *nodeos*.

To create you own users filesystem, its structure is just that each folder on
root directory will be considered a valid user, and each one must have unique
UIDs & GIDs diferent from the others, being this ones different of zero, and
ideally set with an umask 0077 (access only to owner).

The system will craft a per-user root filesystem on top of each one of the users
directories. If there's a (non mandadory) user folder with UID & GID equal to
zero (normally *root* user), this will be considered specially and will have a
*home* mount point with the root of the partition, so it can access to the users
home folders for administrative purposses.
