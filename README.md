# MBONA3models
Three kernelized learning models for insect brain: (Dorsophilla Mushroom body Output Neurons,  alpha'3 compartment)
## Requirements 
```
Linux environment(Ubuntu 24.04 is recommended) or WSL2 (in the case of Windows11 environment)
python3.12
numpy1.26.3
gnuplot6.0
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

3) Edit config.yaml
```config.yaml``` is the shared parameters for model1, model2 and model3.
Please customize the parameters to make them be suit to your specifications.
```
# Example YAML configuration for mainWorker4model1-3.py
# Fields required by the script:
#   gamma: float
#   inputsize: integer (number of input features per instance)
#   outputsize: integer (number of output values per instance)
#   budget: integer (model budget parameter)

gamma: 4.0
inputsize: 5
outputsize: 40
budget: 20
```
The meaning of each parameter is described in our paper.

3) Execute simulations
```
./goall4model1.sh
./goall4model2.sh
./goall4model3.sh
```
It takes a little bit long time to complete them.
After finishing the programs, you can find archived result files in results/.
The archived files are to be used to the next data-analysis.

5) Execute data analysis
```
cd dataAnalysis
./goallDataAnalysis.sh
```
After finishing the data-analysis process, you can find the resultant figures in png format.

## The detailed usage for mainWorker4model[1-3].py
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
## datasets
The datasets are stored in ```./datasets/```.
In this directory, a large number of dataset files. These files are used for the learning of model1, model2 and model3.
You can also find the python code ```NonIIDGeneratorPlus.py```.
This code is for generating the dataset files. 
The dataset is based on a Markov chain model.
You can re-generate the dataset files by
```
python3 NonIIDGeneratorPlus.py
```
