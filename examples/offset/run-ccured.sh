#!/bin/bash

llvm-link test.bc neschecklib.bc -o test-linked.bc
opt -o test-opt.bc -load ../../ccured/build/libnescheck.so -nescheck -stats -time-passes < test-linked.bc > test.nescheckout
