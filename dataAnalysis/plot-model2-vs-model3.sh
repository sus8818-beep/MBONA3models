#!/bin/bash
./gettail.sh 0.99
./gettail.sh 0.999
./gettail.sh 0.9999
gnuplot plot-forgetron-vs-LRU-sp0.99.plt
gnuplot plot-forgetron-vs-LRU-sp0.999.plt
gnuplot plot-forgetron-vs-LRU-sp0.9999.plt
