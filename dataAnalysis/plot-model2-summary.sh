#!/bin/bash
 cd ../results
 tar -xzvf results-model2-0.1-0.5_final_summary.tgz results-model2-0.1-0.5_summary.txt
 tar -xzvf results-model2-0.3-0.5_final_summary.tgz results-model2-0.3-0.5_summary.txt
 tar -xzvf results-model2-0.5-0.5_final_summary.tgz results-model2-0.5-0.5_summary.txt
 tar -xzvf results-model2-0.7-0.5_final_summary.tgz results-model2-0.7-0.5_summary.txt
 tar -xzvf results-model2-0.9-0.5_final_summary.tgz results-model2-0.9-0.5_summary.txt
 cd -
 gnuplot plot-model2-summary.plt
cd ../results
\rm *.txt
cd -
