#!/bin/bash

perf script > perf.tmp1
/usr/local/flamegraph/stackcollapse-perf.pl perf.tmp1 > perf.tmp2
/usr/local/flamegraph/flamegraph.pl perf.tmp2 > perf.svg
rm -f perf.tmp1 perf.tmp2
