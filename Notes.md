## Some notes on how to combine ccured with KLEE.


* Global variables should always be SAFE when used (no need to check)
    * Because they only have declaration and have never been used so far; other variables may have dependencies upon them but they will be classified

* For other variables:
    * General idea is to record SAFE pointers during ccured analysis and use the records to reduce unnecessary checking in KLEE
    * How to record this map?
        * Instead of recording all the three types of pointers, how about we only record SEQ and DYN pointers as they only hold a small portion of all the pointers?


### Ccured code analysis
* All non-pointer type variables are classified as SAFE. (Should also make sense to KLEE)

### Questions

* How does KLEE handle DYN pointers?

* Can KLEE detect memory errors relevant to dynamic runtime information, rather than simple out of bound error that can be verified statically?
    * Need to find an example to support the claim (could be good future work if KLEE can not detect it?)

### Updates on 4/10/2022

* The mapping uses the debug information, as the IR code is modified during Ccured analysis

* The number of SEQ/DYN pointers is quite low as we only concentrate on store/load instructions

* To do list

    * set the stable file name to record the SEQ/DYN pointer infor
    * check the dup of the records when performing the inserting, as the records current reported are not the same as it should be.
    * modification from KLEE'side, including the operation of reading the recording file and checking whether it should perform memory checking on a store/load instruction
