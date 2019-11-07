let MiniSATWrapper = require('./MiniSATWrapper.js');
window.addEventListener('load', windowReady, false);

function windowReady() {
    MiniSATWrapper.setWasmPath("/wasm/minisat.wasm");
    document.getElementById("btnTest").addEventListener("click", runTests);
}

function runTests(){
	assert("p cnf 3 2\n1 -3 0\n2 3 -1 0", "SAT").then(_=>{
        return assert("c This is a comment line.\np cnf 3 2\n1 -3 0\n2 3 -1 0", "SAT");
    }).then(_=>{
        return assert("p cnf 1 2\n1 0\n-1 0", "UNSAT");
    }).then(_=>{
        return assert("Hello, world!", "");
    }).then(_=>{
        // all tests worked
        document.getElementById("divStatus").style.backgroundColor = "green";
    }).catch(reason=>{
        // at least one test failed
        document.getElementById("divStatus").style.backgroundColor = "red";
    });
}

function assert(dimacs, expected) {
    return MiniSATWrapper.run(dimacs).then(result=>{
        let parsedResult = result[1].split('\n')[0];
        console.log(`Got:      ${parsedResult}`);
        console.log(`Expected: ${expected}`);
        let success = (parsedResult === expected)
        console.log(`Success:  ${success}`);
        console.log("--------------------------------");
        if(success){
            return Promise.resolve();
        } else{
            return Promise.reject(`${parsedResult} !=== ${expected}`);
        }
    });
}

window.runMiniSat = function(){
    fetch("./problems/cnf1").then(response=>{
        return response.text();
    }).then(text=>{
        return MiniSATWrapper.run(text);
    }).then(result=>{
        console.log(result[0]);
        console.log(result[1]);
    });
}