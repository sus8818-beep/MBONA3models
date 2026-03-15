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
###### for model1 #######
for ((n=1; n<10; n++)); do
    ./run-shrink-sweep.sh -e mainWorker4model1.py -p ./config.yaml -d $DATASETDIR/data0.$n-0.5 -n 50 -r $RESULTDIR/model1result0.$n-0.5 -pr 0.0001
    cd $RESULTDIR
    tar -czvf results-model1-0.$n-0.5-prth0.0001.tgz *.dat
    rm *.dat
    cd -
done
for ((n=1; n<10; n++)); do
    ./run-shrink-sweep.sh -e mainWorker4model1.py -p ./config.yaml -d $DATASETDIR/data0.$n-0.5 -n 50 -r $RESULTDIR/model1result0.$n-0.5 -pr 0.001
    cd $RESULTDIR
    tar -czvf results-model1-0.$n-0.5-prth0.001.tgz *.dat
    rm *.dat
    cd -
done
for ((n=1; n<10; n++)); do
    ./run-shrink-sweep.sh -e mainWorker4model1.py -p ./config.yaml -d $DATASETDIR/data0.$n-0.5 -n 50 -r $RESULTDIR/model1result0.$n-0.5 -pr 0.01
    cd $RESULTDIR
    tar -czvf results-model1-0.$n-0.5-prth0.01.tgz *.dat
    rm *.dat
    cd -
done
###### for model3 #######
for ((n=1; n<10; n++)); do
    ./run-shrink-sweep.sh -e mainWorker4model3.py -p ./config.yaml -d $DATASETDIR/data0.$n-0.5 -n 50 -r $RESULTDIR/model3result0.$n-0.5 -sp 0.99999
    cd $RESULTDIR
    tar -czvf results-model3-0.$n-0.5.tgz *.dat
    rm *.dat
    cd -
done
