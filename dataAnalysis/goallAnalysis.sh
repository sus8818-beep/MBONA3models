#!/bin/bash
 #goallAnalysis.sh execute all shell-scripts.
 #
 # for model1
 ./summary_shrink_ratio.sh 1 prth0.01
 ./summary_shrink_ratio.sh 1 prth0.001
 ./summary_shrink_ratio.sh 1 prth0.0001
 # for model2
 ./summary_shrink_ratio.sh 2
 # make graphs
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
 # for model2 vs model3
 ./gettail.sh
 gnuplot plot-forgetron-vs-LRU.plt
