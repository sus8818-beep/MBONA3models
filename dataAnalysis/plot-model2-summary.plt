set term png
set output 'model2sensitivity.png'
set title 'model2 sensitivity to shrink-ratio' font "Arial,14"
set xlabel 'Shrink ratio' font "Arial,12"
set ylabel 'Mean cumulative errors' font "Arial,12"
plot \
'../results/results-model2-0.1-0.5_summary.txt' every 5 w errorbar lc "red" notitle, '../results/results-model2-0.1-0.5_summary.txt' w l ti 'Ps:0.1, Pc:0.5' lc "red", \
'../results/results-model2-0.3-0.5_summary.txt' every 5 w errorbar lc "blue" notitle, '../results/results-model2-0.3-0.5_summary.txt' w l ti 'Ps:0.3, Pc:0.5' lc "blue", \
'../results/results-model2-0.5-0.5_summary.txt' every 5 w errorbar lc "green" notitle, '../results/results-model2-0.5-0.5_summary.txt' w l ti 'Ps:0.5, Pc:0.5' lc "green", \
'../results/results-model2-0.7-0.5_summary.txt' every 5 w errorbar lc "magenta" notitle, '../results/results-model2-0.7-0.5_summary.txt' w l ti 'Ps:0.7, Pc:0.5' lc "magenta", \
'../results/results-model2-0.9-0.5_summary.txt' every 5 w errorbar lc "orange" notitle, '../results/results-model2-0.9-0.5_summary.txt' w l ti 'Ps:0.9, Pc:0.5' lc "orange"
#pause -1
