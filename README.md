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

## Usage
Usage of minisat-wasm as a CommonJS module is demonstrated in `test.js`:

```js
const Module = require("./minisat-wasm.js");

let solve = null;

Module.onRuntimeInitialized = () => {
	try {
		solve = Module.cwrap("solve", "string", ["string", "number"]);
		if (solve) {
			run();
		}
	}
	catch (error) {
		console.error(error.message);
	}
};

function run() {
	assert("p cnf 3 2\n1 -3 0\n2 3 -1 0", "SATISFIABLE");
	assert("p cnf 1 2\n1 0\n-1 0", "UNSATISFIABLE");
	assert("Hello, world!", "");
}

function assert(dimacs, expected) {
	let result = solve(dimacs, dimacs.length);
	console.log(`Got:      ${result}`);
	console.log(`Expected: ${expected}`);
	console.log(`Success:  ${result === expected}`);
	console.log("--------------------------------");
}
```

## Original License(s)
### MiniSat
Copyright (c) 2003-2006, Niklas Een, Niklas Sorensson  
Copyright (c) 2007-2010  Niklas Sorensson

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
