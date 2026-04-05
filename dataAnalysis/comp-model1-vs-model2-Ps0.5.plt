set term png
set output 'model1-vs-model2-Ps0.5.png'
set title 'model1 vs model2 P=0.5' font "Arial,14"
set xlabel 'Shrink ratio' font "Arial,12"
set ylabel 'Mean cumulative errors' font "Arial,12"
plot \
'../results/results-model1-0.5-0.5-prth0.01_summary.txt' every 5 w errorbar notitle lc "red", \
'../results/results-model1-0.5-0.5-prth0.01_summary.txt' w l lc "red" ti "model1 Pruning-threshold=0.01", \
'../results/results-model1-0.5-0.5-prth0.001_summary.txt' every 5 w errorbar notitle lc "green", \
'../results/results-model1-0.5-0.5-prth0.001_summary.txt' w l lc "green" ti "model1 Pruning-threshold=0.001", \
'../results/results-model1-0.5-0.5-prth0.0001_summary.txt' every 5 w errorbar notitle lc "cyan", \
'../results/results-model1-0.5-0.5-prth0.0001_summary.txt' w l lc "cyan" ti "model1 Pruning-threshold=0.0001", \
'../results/results-model2-0.5-0.5_summary.txt' every 5 w errorbar notitle lc "blue", \
'../results/results-model2-0.5-0.5_summary.txt' w l lc "blue" ti "model2"
#pause -1
