RESULTDIR=./results
DATASETDIR=./dataset
SYSTEMDIR=./
###### for model3 #######
for ((n=1; n<10; n++)); do
    ./run-shrink-sweep.sh -e mainWorker4model3.py -p ./config.yaml -d $DATASETDIR/data0.$n-0.5 -n 50 -r $RESULTDIR/model3result0.$n-0.5 -sp 0.9999
    cd $RESULTDIR
    tar -czvf results-model3-0.$n-0.5.tgz *.dat
    rm *.dat
    cd -
done
