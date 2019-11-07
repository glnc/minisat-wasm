#!/bin/sh

# create needed folders if they dont exist already
mkdir -p release
mkdir -p demo/wasm

# clean demo
rm ./demo/wasm/minisat.wasm
rm ./demo/bundle.js

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

# if demo, build demo with browserify
if [ -n "$1" -a "$1" = "demo" ]
then
    echo "build the demo"
    cp ./src_js/demo.js ./release/demo.js
    # browserify
    browserify ./release/demo.js -o ./demo/bundle.js
    cp ./release/minisat.wasm  ./demo/wasm/minisat.wasm
    cp ./release/minisat.wast  ./demo/wasm/minisat.wast
    rm ./release/demo.js
fi
