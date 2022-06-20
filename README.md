# Homepage of FastKLEE

Also, please check out our [video demonstration](https://youtu.be/fjV_a3kt-mo) of FastKLEE


The tool FastKLEE has been tested on Ubuntu 18.04 and hasn’t been tested on other platforms up to now, so Ubuntu 18.04 is preferred.



## Installation


To install FastKLEE, users could execute `./setup.sh` to set up both Ccured type inference system and the FastKLEE symbolic execution engine.

After installing the tool, copy the instrument file `neschecklib.bc` and the ccured analysis library `libccured.so` to the testing folder (`./examples/fastklee-test` in this tutorial).

## Compile source code to the intermediate representation (IR)

For a single test program (e.g., `test.c`), users can get IR by executing

```
clang -emit-llvm -c test.c -o test.bc
```

For more complex test programs (e.g., GNU Coreutils), we recommend users to follow the [officical document](http://klee.github.io/tutorials/testing-coreutils/) to get their IR code file.

Here, we assume users have obtained the test program and compiled it into IR code. We take the `cat` test program in GNU Coreutils as an example to illustrate the following process.

## Instrument IR for preparing type inference

```
llvm-link cat.bc neschecklib.bc -o cat-linked.bc
```
## Type inference and produce CheckList

```
opt -load libccured.so -nescheck -stats -time-passes < cat-linked.bc >& /dev/null
```


## Conduct faster symbolic execution
```
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
```

## Evaluation Results


<img width="368" alt="fastklee-results" src="https://user-images.githubusercontent.com/65850329/174615023-060395aa-0893-410e-aa5f-10c286857540.png">

