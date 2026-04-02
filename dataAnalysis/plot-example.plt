set term png
set output 'example-of-behaviors.png'
set title 'Example of model behaviors' font "Arial,14"
set xlabel 'Shrink ratio' font "Arial,12"
set ylabel 'cumulative errors' font "Arial,12"
plot \
'../results/model1result0.3-0.5-0.77-1.dat' w l ti 'model1(Pruning threshold 0.0001)' lc 'blue', '../results/model2result0.3-0.5-0.77-1.dat' w l ti 'model2 (Forgetron)' lc 'red', '../results/model3result0.3-0.5-0.77-1.dat' w l ti 'model3 (LRU)' lc 'green'

