#!/bin/bash

opt -load ./libccured.so -nescheck -stats -time-passes < cat-linked.bc  >& /dev/null
mv recordings.txt cat-checklist.txt
