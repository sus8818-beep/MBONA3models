RESULTDIR=./results
DATASETDIR=./dataset
SYSTEMDIR=./
###### for model2 #######
for ((n=1; n<10; n++)); do
    ./run-shrink-sweep.sh -e mainWorker4model2.py -p ./config.yaml -d $DATASETDIR/data0.$n-0.5 -n 50 -r $RESULTDIR/model2result0.$n-0.5
    cd $RESULTDIR
    tar -czvf results-model2-0.$n-0.5.tgz *.dat
    rm *.dat
    cd -
done
