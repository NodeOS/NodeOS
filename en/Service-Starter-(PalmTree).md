# PalmTree, the NodeOS Service Starter #
_REPOSITORY:_ [https://github.com/lite20/palmtree](https://github.com/lite20/palmtree)

_NPM MODULE:_ [https://www.npmjs.com/package/palmtree](https://www.npmjs.com/package/palmtree)

## Introduction ##
Sometimes we need scripts, or services to launch on startup. This is a remarkably easy task in NodeOS.
The startup program launcher on NodeOS is called PalmTree. PalmTree uses a simple .json file in the /etc/ folder called "palmtree.json". In this file, which we will refer to as the palmtree, is simply a JSON encoded array of objects. Each object contains at minimum the command to execute. Additionally, you may specify a name, or arguments  to go along. Let's take a look at an example palmtree.

`[
    {
        "command": "plexdl",
        "name": "PlexDL",
        "args": ['beta-gui']
    }
]`

As you can see, a command is specified, a name for the program, and an argument. Only the command is necessary.
On startup, with this palmtree, PalmTree would run the command "plexdl" with the argument "-beta-gui" and if there were any issues, it would report them and refer to the command as "PlexDL".

## Adding or Removing Commands ##
### Manually ###
To add or remove scripts/services from startup, simply remove the object from your palmtree. A graphical GUI is underworks to allow you to do this easily.

### Programatically ###
To add or remove scripts/services from startup programatically, the palmtree.json file is a perfectly formatted JSON file. In NodeJS, you can use `require` to load it, or use the fs module and JSON parse it. Then make your adjustments, be it adding or removing a program, then re-serialize the JSON object and write it back to the file.