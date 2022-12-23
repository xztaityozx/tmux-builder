all: build-result.tar.gz dest

build-result.tar.gz:
	env zsh ./script/build.sh

dest:
	tar xfz ./build-result.tar.gz
