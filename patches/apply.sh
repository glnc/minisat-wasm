#!/bin/bash
for p in ./patches/*.patch; do patch -p0 < $p; done
