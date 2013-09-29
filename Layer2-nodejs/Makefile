default: Release/node Release/Dockerfile

Release:
	mkdir -p Release

Release/node: Release deps/node/out/Release/node
	cp deps/node/out/Release/node Release/node

Release/Dockerfile: Release
	cp share/Dockerfile Release/Dockerfile

deps/node/out/Release/node:
	cd deps/node && $(MAKE)

clean:
	rm -rf Release
	cd deps/node && $(MAKE) clean
