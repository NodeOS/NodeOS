# NodeOS on Docker

## Quick Start

```
sudo name=<MY_NAME>/nodeos ./build
sudo docker run -i -t <MY_NAME>/nodeos
```

## Custom Packages

Customize the included `Dockerfile` by adding new `npkg install` lines:

```
RUN npkg install <PKGNAME>
```

For each line included, that package will be downloaded and included in the OS during build.
Packages that have expose executables via the `bin` key in their `package.json` file will have those executables accessible to the system at runtie.

## Custom Layer Stack

You can specify an alternative set of layers to build your NodeOS image from.
After building your `layer3` base image, first tag the <MY_NAME>/nodeos image as your `<MY_NAME>/nodeos` image:

```
sudo docker tag layer3 <MY_NAME>/nodeos/<MY_NAME>/nodeos
```

Once the <MY_NAME>/nodeos image is tagged, you can run the build script as normal:

```
sudo name=<MY_NAME>/nodeos ./build
```

## Share

If you're proud of your image, share it!

```
sudo docker push <MY_NAME>/nodeos
```

