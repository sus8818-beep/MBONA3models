from models.model1 import model1
import yaml
import os
import argparse

class mainWorker4model1:
    def __init__(self, yamlfilename, datafilename, phi, rmThreshold, resultsfilename):
        self.gamma = None
        self.inputsize = None
        self.outputsize = None
        self.budget = None
        self.cumError = 0  # integer counter
        with open(yamlfilename) as f:
            self.config = yaml.safe_load(f)
            self.gamma = self.config['gamma']
            self.inputsize = self.config['inputsize']
            self.outputsize = self.config['outputsize']
            self.budget = self.config['budget']
        self.phi = phi
        self.rmThreshold = rmThreshold
        self.datafilename = datafilename
        self.resultsfilename = resultsfilename
        self.model = model1(self.gamma, self.budget, self.phi, self.rmThreshold)
        
    def run(self):
        # prevent accidental overwrite of config file (best-effort check)
        # note: yaml.safe_load doesn't record source path, so most reliable check is done at CLI parsing
        with open(self.resultsfilename, 'w') as wf:
            
            with open(self.datafilename) as rf:
                for line in rf:
                    if not line.strip():
                        continue
                    x, y = self.getSingleInstance(line)
                    if x is None or y is None:
                        # skip malformed line
                        continue
                    try:
                        error = self.model.ClassificationErr(x, y)
                        print(f"mainWorker4model1.run() ClassificationErr: {error}")
                    except Exception as e:
                        # If the model raises, log and skip this instance
                        print(f"Warning: mainWorker4model1.run() Exception! ClassificationErr raised for line: {e}")
                        continue
                    # robustly interpret error: prefer numeric comparison, otherwise truthiness
                    try:
                        is_error = int(error < 0)
                    except Exception:
                        is_error = int(bool(error))
                    self.cumError += is_error
                    wf.write(f"{self.cumError}\n")
                    print(f"mainWorker4model1.run() Cumulative Error: {self.cumError}")
                    try:
                        self.model.learning(x, y)
                    except Exception as e:
                        print(f"mainWorker4model1.run() Exception! learning() raised for line: {e}")
                
        
    def getSingleInstance(self, line):
        # parse comma-separated values, tolerate trailing commas/whitespace
        parts = [p for p in line.strip().split(',') if p != '']
        if len(parts) < (self.inputsize + self.outputsize):
            # not enough columns
            print(f"mainWorker4model1.getSingleInstance() Warning: expected at least {self.inputsize + self.outputsize} columns, got {len(parts)}")
            return None, None
        x = []
        y = []
        try:
            for j in range(self.inputsize):
                x.append(float(parts[j]))
            for j in range(self.inputsize, self.inputsize + self.outputsize):
                y.append(float(parts[j]))
        except ValueError as e:
            print(f"mainWorker4model1.getSingleInstance() ValueError: failed to parse floats in line: {e}")
            return None, None
        return x, y



def get_args():
    parser = argparse.ArgumentParser(description="Run model1 with specified parameters.")
    parser.add_argument('--yaml', type=str, required=True, help='Path to the YAML configuration file.')
    parser.add_argument('--data', type=str, required=True, help='Path to the input data file.')
    parser.add_argument('--phi', type=float, required=True, help='Decay factor for the model1.')
    parser.add_argument('--rmThreshold', type=float, required=True, help='rmThreshold for the model1.')
    parser.add_argument('--results', type=str, required=True, help='Path to save the results file.')
    return parser.parse_args()

if __name__ == "__main__":
    args = get_args()
    if not os.path.exists(args.yaml):
        print(f"YAML file {args.yaml} does not exist.")
        exit(1)
    if not os.path.exists(args.data):
        print(f"Data file {args.data} does not exist.")
        exit(1)
    # If the user accidentally set results == yaml, auto-create a safe results path instead of overwriting or aborting.
    if os.path.abspath(args.yaml) == os.path.abspath(args.results):
        yaml_root, yaml_ext = os.path.splitext(args.results)
        candidate = f"{yaml_root}.results.txt"
        counter = 0
        while os.path.exists(candidate):
            counter += 1
            candidate = f"{yaml_root}.results.{counter}.txt"
        print(f"Warning: --results path is the same as --yaml. Using '{candidate}' for results to avoid overwriting the config.")
        args.results = candidate
    print("Start mainWorker4model1")
    worker = mainWorker4model1(args.yaml, args.data, args.phi, args.rmThreshold, args.results)
    worker.run()