# gettail.sh
# This shell script pick up the last cumulative error of each file and unified into combined_LRU?.sh
# combined_LRU?.sh shows differences between model2 vs model3 in cumulative errors.
# You should customise RESULTDIR in line 6 if you need it.
# Usage  ./gettail 
#        ./gettail 0.999
#
#!/bin/sh
RESULTDIR=../results
SPONTANEOUS_SHRINKRATIO=$1
if [ -z $SPONTANEOUS_SHRINKRATIO ]; then
    echo "Usage ./gettail.sh <spontaneous shrink ratio>"
    exit 1
fi

cd $RESULTDIR
for p in $(seq 1 9)
do
   for i in $(seq 60 70)
   do
      for k in $(seq 0 49)
      do
        RATIO=$(awk -v v="$i" 'BEGIN{printf "%.2f", 0.1+v/100}')
        yes | tar -xvf results-model2-0.$p-0.5.tgz model2result0.$p-0.5-$RATIO-$k.dat
        yes | tar -xzvf results-model3-0.$p-0.5-sp$SPONTANEOUS_SHRINKRATIO.tgz model3result0.$p-0.5-$RATIO-$k.dat
        if [ $i -eq 60 ]; then
           if [ $k -eq 0 ]; then
               tail -n 1 model2result0.$p-0.5-$RATIO-$k.dat | cut -d' ' -f2- > forgetron$p.csv
               tail -n 1 model3result0.$p-0.5-$RATIO-$k.dat | cut -d' ' -f2- > LRU$p.csv
           else
               tail -n 1 model2result0.$p-0.5-$RATIO-$k.dat | cut -d' ' -f2- >> forgetron$p.csv
               tail -n 1 model3result0.$p-0.5-$RATIO-$k.dat | cut -d' ' -f2- >> LRU$p.csv
           fi
        else
           tail -n 1 model2result0.$p-0.5-$RATIO-$k.dat | cut -d' ' -f2- >> forgetron$p.csv
           tail -n 1 model3result0.$p-0.5-$RATIO-$k.dat | cut -d' ' -f2- >> LRU$p.csv
        fi
        yes | rm model2result0.$p-0.5-$RATIO-$k.dat
        yes | rm model3result0.$p-0.5-$RATIO-$k.dat
      done
   done

   # concatinate forgetron$p.csv and LRU$p.csv and save it to combined_LRU$p.csv
   paste -d' ' forgetron$p.csv LRU$p.csv > combined_LRU$p.csv

done
cd -

