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
	assert("c This is a comment line.\np cnf 3 2\n1 -3 0\n2 3 -1 0", "SATISFIABLE");
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
