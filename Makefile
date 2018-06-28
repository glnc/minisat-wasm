MAKE=make
EMMAKE=emmake
EMCC=emcc
NODE=node

DIR_RELEASE = ./release
FILENAME_RELEASE = minisat-wasm

DIR_MINISAT = ./minisat
DIR_MINISAT_RELEASE = $(DIR_MINISAT)/build/release/bin
FILENAME_MINISAT = minisat

FILENAME_TEST = test.js

.DEFAULT_GOAL = minisat-wasm

usage:
	@echo "Invoke 'make' to build minisat-wasm using emscripten."
	@echo "Invoke 'make test' to build and test minisat-wasm."
	@echo "Invoke 'make clean' to clean project."

test: minisat-wasm
	cd $(DIR_RELEASE) && $(NODE) $(FILENAME_TEST)

minisat-wasm: minisat
	mkdir -p $(DIR_RELEASE)
	cd $(DIR_MINISAT_RELEASE) && ln -s $(FILENAME_MINISAT) $(FILENAME_MINISAT).bc
	$(EMCC) -O3 -s EXPORTED_FUNCTIONS='["_solve"]' -s 'EXTRA_EXPORTED_RUNTIME_METHODS=["ccall", "cwrap"]' -s TOTAL_MEMORY=67108864 -s TOTAL_STACK=26214400 $(DIR_MINISAT_RELEASE)/$(FILENAME_MINISAT).bc -o $(DIR_RELEASE)/$(FILENAME_RELEASE).js
	cp $(FILENAME_TEST) $(DIR_RELEASE)
	@echo "> Built minisat-wasm using emscripten"

minisat:
	cd $(DIR_MINISAT) && $(EMMAKE) make clean
	cd $(DIR_MINISAT) && $(EMMAKE) make r
	@echo "> Built MiniSat"

minisat-patched: minisat-cloned
	./patches/apply.sh
	@echo "> Patched MiniSat to be compatible with emscripten"

minisat-cloned: clean-minisat
	git clone https://github.com/niklasso/minisat.git
	@echo "> Cloned MiniSat from GitHub"

clean: clean-minisat
	rm -rf $(DIR_RELEASE)
	@echo "> Cleaned project"

clean-minisat:
	rm -rf $(DIR_MINISAT)

.PHONY: usage test minisat-wasm minisat minisat-patched minisat-cloned clean clean-minisat
