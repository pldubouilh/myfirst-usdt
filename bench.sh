curpath=$(dirname $0)
( timeout 10 ${curpath}/nodtrace $1 > log 2>&1 ) & ( timeout 10 ${curpath}/testdtrace $1 > logp 2>&1 )
cat log logp | ./summarize
