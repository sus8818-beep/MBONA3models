#!/bin/bash
#goallAnalysis.sh execute all shell-scripts.
#
# for making model1 data
./mk-model1-data.sh > /dev/null
# for making model2 data
 ./summary_shrink_ratio.sh 2 > /dev/null
# make figures
./plot-model2-summary.sh
./plot-model1-summary.sh
./plot-model1-vs-model2.sh
# for model2 vs model3
./plot-model2-vs-model3.sh
# example of model behaviors
./plot-example-behaviors.sh
