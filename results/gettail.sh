#!/bin/sh
for p in $(seq 1 9)
do
   for i in $(seq 0 100)
   do
      for k in $(seq 0 49)
      do
        RATIO=$(awk -v v="$i" 'BEGIN{printf "%.10g", 0.1+v/100}')
        yes | tar -xvf results-model2-0.$p-0.5.tgz model2result0.$p-0.5-$RATIO-$k.dat
        yes | tar -xzvf results-model3-0.$p-0.5.tgz model3result0.$p-0.5-$RATIO-$k.dat
        if [ $i -eq 0 ]; then
           tail -n 1 model2result0.$p-0.5-$RATIO-$k.dat | cut -d' ' -f2- > forgetron$p.csv
           tail -n 1 model3result0.$p-0.5-$RATIO-$k.dat | cut -d' ' -f2- > LRU$p.csv
        else
           tail -n 1 model2result0.$p-0.5-$RATIO-$k.dat | cut -d' ' -f2- >> forgetron$p.csv
           tail -n 1 model3result0.$p-0.5-$RATIO-$k.dat | cut -d' ' -f2- >> LRU$p.csv
        fi
        yes | rm model2result0.$p-0.5-$RATIO-$k.dat
        yes | rm model3result0.$p-0.5-$RATIO-$k.dat
      done
   done

   # forgetron$p.csvとLRU$p.csvを結合して新しいファイルに保存
   paste -d' ' forgetron$p.csv LRU$p.csv > combined_LRU$p.csv

done

