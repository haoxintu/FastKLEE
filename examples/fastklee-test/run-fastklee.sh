#!/bin/bash

rm -rf output-fastklee-*

fastklee --simplify-sym-indices --write-cvcs --write-cov --output-module \
--max-memory=1000 --disable-inlining --optimize --use-forked-solver \
--use-cex-cache --libc=uclibc --posix-runtime \
--external-calls=all --only-output-states-covering-new \
--env-file=test.env --run-in-dir=/tmp/sandbox \
--max-sym-array-size=4096 --max-solver-time=30s --max-time=1min \
--watchdog --max-memory-inhibit=false --max-static-fork-pct=1 \
--max-static-solve-pct=1 --max-static-cpfork-pct=1 --switch-type=internal \
--use-batching-search --batch-instructions=10000 \
--search=dfs \
--output-dir="output-fastklee-cat" \
./cat.bc --sym-args 0 1 10 --sym-args 0 2 2 --sym-files 1 8 --sym-stdin 8 --sym-stdout
