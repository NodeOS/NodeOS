Let's define some terminology used for this project.

1. The **technology** is the clever abstraction.
   It is performant, modularized, and flexible.
   You need a mental model present to work with a technology,
   but once it's in place you can do a lot.

   Unfortunately technology doesn't sell.
   Technology is necessary, but it is not the end goal.
2. The **product** is the human face on technology.
   It is specific, and focused.
   If often uses only one aspect of a technology,
   but it solves a real human problem.

   Designing a product is harder than designing a technology.
   Smart people find products hard to design,
   because products are all about compromise.

Node-os is *both* a technology and a product,
so it's important to understand which part we're talking about at any given time.
For example:

- [[asgard]] and [[init]] are a technologies,
  they are clever abstractions that makes building
  certain os-related products easier.
- [[npkg]] is a product.
  It's designed to meet a human need,
  and not require a lot of foreknowledge to use.
- [[help]] is a product. In many ways `help` should be the ambassador for the system.
  Help is not `man` or `info`. It is not exhaustive; it is focused.
  The `help` command focuses on guiding people through the system.
- A few things like the [[FileSystem]] are hybrids of technology and product.
  We move things around to technically organize the system,
  but we don't want the file system to seem foreign to users.

## the product experience

What should a users first experience with node-os be like?

> users should want to have the node-os experience everywhere

To that end, we want `npkg` to be the gateway to a users first experience.
It should quickly facilitate

1. installing packages
2. running services
3. discovering packages
4. giving helpful feedback

Where (4) may be most important.
There will not be an engineer standing over the should of most people's first
node-os experience.
You should be able to use node-os from the command line experience alone.

### first experience

What do we want the first experience to look like? *(let's improve on this)*

```bash
welcome to node-os

type help to get started

$
```

Typing `help` should display

```bash
Try the following

  1. help npkg    learn about the npkg command
  2. help home    learn about your home directory

$
```

Ideas

1. make `help` stateful, so it can offer you conextual help

### ongoing experience

Why are people using node-os, and what problems are they trying to solve?
Answering these quesitons are important to creating a product that people will want to use.

#### vanilla

1. people want to run their node app quickly, without fussing around with init config files
2. people want to configure a system consistently without puppet/chef or other config-management tools

#### wild

1. people want to write a distributed file system with leveldb and http

#### ultimate

1. people want to do tcp/ip parsing in user-space with javascript
