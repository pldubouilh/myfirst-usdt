perf eval for dtrace probes test

```sh
# make version with test
make 
mv test testdtrace

# amend/toggle dtrace probe test line 14/15
vim test.c
make
mv test nodtrace

# test
./bench.sh
```
