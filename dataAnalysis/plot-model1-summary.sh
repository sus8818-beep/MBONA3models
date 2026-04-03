#!/bin/bash
cd ../results
 \rm *.txt
 tar -xzvf results-model1-0.1-0.5-prth0.01_final_summary.tgz results-model1-0.1-0.5-prth0.01_summary.txt
 tar -xzvf results-model1-0.3-0.5-prth0.01_final_summary.tgz results-model1-0.3-0.5-prth0.01_summary.txt
 tar -xzvf results-model1-0.5-0.5-prth0.01_final_summary.tgz results-model1-0.5-0.5-prth0.01_summary.txt
 tar -xzvf results-model1-0.7-0.5-prth0.01_final_summary.tgz results-model1-0.7-0.5-prth0.01_summary.txt
 tar -xzvf results-model1-0.9-0.5-prth0.01_final_summary.tgz results-model1-0.9-0.5-prth0.01_summary.txt
 cd -
 gnuplot plot-model1-summary-prth0.01.plt
 cd ../results
 \rm *.txt
 tar -xzvf results-model1-0.1-0.5-prth0.001_final_summary.tgz results-model1-0.1-0.5-prth0.001_summary.txt
 tar -xzvf results-model1-0.3-0.5-prth0.001_final_summary.tgz results-model1-0.3-0.5-prth0.001_summary.txt
 tar -xzvf results-model1-0.5-0.5-prth0.001_final_summary.tgz results-model1-0.5-0.5-prth0.001_summary.txt
 tar -xzvf results-model1-0.7-0.5-prth0.001_final_summary.tgz results-model1-0.7-0.5-prth0.001_summary.txt
 tar -xzvf results-model1-0.9-0.5-prth0.001_final_summary.tgz results-model1-0.9-0.5-prth0.001_summary.txt
 cd -
 gnuplot plot-model1-summary-prth0.001.plt
 cd ../results
 \rm *.txt
 tar -xzvf results-model1-0.1-0.5-prth0.0001_final_summary.tgz results-model1-0.1-0.5-prth0.0001_summary.txt
 tar -xzvf results-model1-0.3-0.5-prth0.0001_final_summary.tgz results-model1-0.3-0.5-prth0.0001_summary.txt
 tar -xzvf results-model1-0.5-0.5-prth0.0001_final_summary.tgz results-model1-0.5-0.5-prth0.0001_summary.txt
 tar -xzvf results-model1-0.7-0.5-prth0.0001_final_summary.tgz results-model1-0.7-0.5-prth0.0001_summary.txt
 tar -xzvf results-model1-0.9-0.5-prth0.0001_final_summary.tgz results-model1-0.9-0.5-prth0.0001_summary.txt
 cd -
 gnuplot plot-model1-summary-prth0.0001.plt
cd ../results/
\rm *.txt
cd -
