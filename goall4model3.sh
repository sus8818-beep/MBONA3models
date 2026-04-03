RESULTDIR=./results
DATASETDIR=./dataset
SYSTEMDIR=./
###### for model3 #######
#
for sp_ratio in 0.99 0.999 0.9999; do
    for ((n=1; n<10; n++)); do
        ./run-shrink-sweep.sh -e mainWorker4model3.py -p ./config.yaml -d $DATASETDIR/data0.$n-0.5 -n 50 -r $RESULTDIR/model3result0.$n-0.5 -sp $sp_ratio
        cd $RESULTDIR
        tar -czvf results-model3-0.$n-0.5-sp$sp_ratio.tgz *.dat
        rm *.dat
        cd -
    done
done
