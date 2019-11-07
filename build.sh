#!/bin/sh

# create needed folders if they dont exist already
mkdir -p release

# clean
rm ./release/MiniSATWrapper.js
cd ./src
make clean

# rebuild
emmake make
cd ..
cp ./src_js/MiniSATWrapper.js ./release/MiniSATWrapper.js
cp ./src/build/release/bin/minisat.js ./release/minisat.js
cp ./src/build/release/bin/minisat.wasm ./release/minisat.wasm
cp ./src/build/release/bin/minisat.wast ./release/minisat.wast
