# minisat-wasm
Compile MiniSat to WebAssembly using emscripten.

*Note*: This is a fork of https://github.com/jgalenson/research.js where we only care about the minisat directory.

MiniSat (http://minisat.se) will be cloned from the original repository (https://github.com/niklasso/minisat) and patched in order to be compatible with emscripten. Most notably minisat-wasm will parse the DIMACS input from a string instead of a file.

## Prerequisites
* make
* emscripten

Follow the instructions on https://kripken.github.io/emscripten-site/docs/getting_started/downloads.html in order to install emscripten and all of its dependencies.

## Building
Invoke `make` to build minisat-wasm using emscripten.

Invoke `make test` to build and test minisat-wasm.

Invoke `make clean` to clean project.
