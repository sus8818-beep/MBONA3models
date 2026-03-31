# MBONA3models
Three kernelized learning models for insect brain: (Dorsophilla Mushroom body Output Neurons,  alpha'3 compartment)
## Requirements 
```
python3.12
numpy1.26.3
```
## Install
```
clone git@github.com:sus8818-beep/MBONA3models.git
```
## Usage

1) Enter your python virtual environment. For example,
```
source ~/venv/bin/activate
```
2) Enter root directory:
```
cd MBONA3models
```
In this directory, there are three mainWorkers: 
```mainWorker4model1.py```, ```mainWorker4model2.py```, ```mainWorker4model3.py```.
These codes make run each learning model. Their behaviors can be controlled by commandlines.
The commandlines for these three codes are almost the same.
In the following explanation, standard usage is shown in the case of model1.
Actually, the there are slightly different command line options in model2 and model3.
You can see the detailed examples in ```run-shrink-sweep.sh```

### mainWorker4model1.py
mainWorker4model1.py make class model1 work. class model1 learns learning sample one by one in a online learning manner.
The results are represented by a cumulative error. The error is written in the specified CSV file.
If the cumulative error is low, the learning model is better.

You can get the detailed command line options by
```
python3 mainWorker4model1.py -h
```
Then, you can obtain
```
usage: mainWorker4model1.py [-h] --yaml YAML --data DATA --phi PHI --rmThreshold RMTHRESHOLD --results
                            RESULTS

Run model1 with specified parameters.

options:
  -h, --help            show this help message and exit
  --yaml YAML           Path to the YAML configuration file.
  --data DATA           Path to the input data file.
  --phi PHI             Decay factor for the model1.
  --rmThreshold RMTHRESHOLD
                        rmThreshold for the model1.
  --results RESULTS     Path to save the results file.
```
Example of usage:
```
python3 mainWorker4model1.py --yaml config.yaml --data ./dataset/data0.1-0.5-0.csv --phi 0.8 --results result.dat  --rmThreshold 0.001
```
The command lines for model1,2,3 are almost the same, but there are model specific command lines as follows.
```
model1: --rmthreshold    : Pruning threshold
model3: --spontaneousPhi : Spontaneous weight shrinkage parameter
```
