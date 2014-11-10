Although is expected NodeOS to has in mid-term future support for audio & graphics, it will not have a GUI by itself. Instead, NodeOS will offer some graphic primitives that would allow to third-party Node.js modules to build a GUI by themselves. It's not clear yet how this low-level primitives APIs will be, but due to the relationship of Node.js with Javascript and this last one with the Web, there are two clear candidates that would allow an easy transition and/or adaptation to current available applications:

# canvas
The [canvas](http://www.w3.org/wiki/HTML/Elements/canvas) object offer a bi-dimensional surface where pixels can be painted independently similar to other 2D environments like SDL or DirectFB, so it's a natural choice as a graphic primitive for drawing on a screen, and its API also has support for 3D drawing by using WebGL.

## How can be done
This could be done by using [node-canvas](https://github.com/Automattic/node-canvas) by adapting it to use an EGL-backed Cairo graphic library, or [node-openvg-canvas](https://github.com/luismreis/node-openvg-canvas) that's compatible with node-canvas but more focused on screen rendering by using OpenVG library.

## Use case
Canvas main use cases are pure Javascript flash-like applications fully build by using a canvas object like games and emulators, so they could be easily ported to Node.js and NodeOS.

# web renderer
Canvas object and other framebuffer-like APIs are too low-level to use as basis for some applications. For more advanced desktop-like applications, a good alternative is to use a web renderer. This is similar to how ChromeOS or FirefoxOS works, and [there's interest on this happening on NodeOS](https://medium.com/javascript-ecosystem/booting-to-node-2d620ac5402).

Currently there are some projects with a similar focus like [node-webkit](https://github.com/rogerwang/node-webkit), [atom-shell](https://github.com/atom/atom-shell) or [thrust](https://github.com/breach/thrust). Problems with them is that they are focused on development of desktop apps and integration using web technologies, so they are a little bit bloated for an environment like NodeOS where's no desktop at all and a thiner layer like the ones used in ChromeOS or FirefoxOS is a better alternative. Also, node-webkit and atom-shell allow direct access to Node.js functions from the DOM, making it more dificult to access to that applications remotely.

## How can be done
The best alternative is [Chrome Embebed Framework](https://code.google.com/p/chromiumembedded/) (CEF), already being used by node-webkit, atom-shell and thrust. It should be used as a simple web renderer or web browser without any special intregation with Node.js or NodeOS, just only being compiled and packaged as a NPM package, and access to the Node.js app or NodeOS functionality by using a REST API or WebSockets, depending of the decision of the developer, and the interface files served by a static web server (that could be the same app server). If there's a common pattern on the development process, it could be bundle as a framework, but this is not intended at a short or medium term to allow more flexibility and creation liberty to the developers.

This architecture allow the interface of the application to be isolated from the server functionality and the Node.js/NodeOS internal, so the app can be also accesible from an external web browser. An example of a Node.js application that follow this architecture is [Node.js Music Player](https://github.com/benkaiser/node-music-player). This is clearly more focused for daemonized applications, for "one shot" ones there should be needed to investigate how to do it, but an alternative is to exec the server and open the client window at the same time.

## Use cases
Depending of the grade of integration between the GUI and the server done by the developer, we can see three kind of applications or use cases:

* **webapp**: the application is fully build in client-side Javascript and HTML and don't need a server to run it, only a static web server to serve the files. This is the same concept that traditional web apps and will run entirely on the CEF environment.
* **server-side logic**: the logic of the application is fully on the Node.js server process, and the interface only show the results. This concept is similar to traditional or AJAX-based web architecture.
* **client-side logic**: the logic of the application is on the webapp, and the server acts as a proxy to allow access to the priviledged Node.js/NodeOS APIs (filesystem, TCP ports...). This is similar to the development of ChromeOS or FirefoxOS apps, with the difference that the use of priviledged APIs is not done by custom specific Javascript objects but instead by a custom protocol offered by the proxy server. This could be think to be added in the future as an uniform API on NodeOS itself instead of each developer crafting their own proxy server, for example by showing a REST API to that priviledged functionality or similar.