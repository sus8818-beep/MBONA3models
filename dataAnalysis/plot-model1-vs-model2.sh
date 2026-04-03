#!/bin/bash
# model1 vs model2
 cd ../results
 for i in {1..9};
 do
     tar -xzvf results-model2-0.$i-0.5_final_summary.tgz results-model2-0.$i-0.5_summary.txt
     tar -xzvf results-model1-0.$i-0.5-prth0.01_final_summary.tgz results-model1-0.$i-0.5-prth0.01_summary.txt
     tar -xzvf results-model1-0.$i-0.5-prth0.001_final_summary.tgz results-model1-0.$i-0.5-prth0.001_summary.txt
     tar -xzvf results-model1-0.$i-0.5-prth0.0001_final_summary.tgz results-model1-0.$i-0.5-prth0.0001_summary.txt
 done
 cd -
 gnuplot comp-model1-vs-model2-Ps0.1.plt
 gnuplot comp-model1-vs-model2-Ps0.3.plt
 gnuplot comp-model1-vs-model2-Ps0.5.plt
 gnuplot comp-model1-vs-model2-Ps0.7.plt
 gnuplot comp-model1-vs-model2-Ps0.9.plt
 cd ../results
 \rm *.txt
 cd -
