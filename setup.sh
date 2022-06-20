#!/bin/bash

# install dependencies
sudo apt-get install build-essential cmake curl file g++-multilib gcc-multilib git libcap-dev libgoogle-perftools-dev libncurses5-dev libsqlite3-dev libtcmalloc-minimal4 python3-pip unzip graphviz doxygen clang-10 llvm-10

# build ccured

cd ccured
mkdir build
cd build
cmake ..
make -j12
cd ..
cd ..

# build FastKLEE

## build constraint solver STP
git clone https://github.com/stp/stp.git
cd stp
git checkout tags/2.3.3
mkdir build
cd build
cmake ..
make -j12
sudo make install
cd ..
cd ..

## build uclibc
git clone https://github.com/klee/klee-uclibc.git
cd klee-uclibc
./configure --make-llvm-lib
make -j12
cd ..

## build fastklee
mkdir build
cd build
cmake -DENABLE_SOLVER_STP=ON -DENABLE_POSIX_RUNTIME=ON -DENABLE_KLEE_UCLIBC=ON -DKLEE_UCLIBC_PATH=../klee-uclibc \
    -DLLVM_CONFIG_BINARY=/usr/bin/llvm-config-10 -DLLVMCC=/usr/bin/clang-10 -DLLVMCXX=/usr/bin/clang++-10 -DCMAKE_BUILD_TYPE=Debug ..
make -j12
sudo make install
cd ..
