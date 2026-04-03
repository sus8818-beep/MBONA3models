#!/bin/bash
cd ../results
\rm *.txt
tar -xzvf results-model1-0.3-0.5-prth0.0001.tgz model1result0.3-0.5-0.77-1.dat
tar -xzvf results-model2-0.3-0.5.tgz model2result0.3-0.5-0.77-1.dat
tar -xzvf results-model3-0.3-0.5.tgz model3result0.3-0.5-0.77-1.dat
cd -
gnuplot plot-example.plt
cd ../results
\rm *.dat
cd -

