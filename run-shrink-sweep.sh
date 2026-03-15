#!/usr/bin/env bash
set -euo pipefail

EXECODE=./mainWorker4model2.py
PARAM=./config.yaml
DATA=./dataset/data0.1-0.5
RESULT=./result/result
SPONTANEOUSPHI=0.99999
NUM=1
MAX_JOBS=9   # maximum number of parallel jobs

# Usage helper and simple CLI parsing for overriding PARAM
usage(){
  cat <<EOF
Usage: $0 [-e|--execode pythonsrcfilename -p|--parameter PARAMFILE -d|--datafile DATAHEADFILENAME -n|--numDataset NUMBER -r|--result RESULTFILENAME -pr PRUNETHRESHOLD -sp SPONTANEOUSPHI]

Options:
  -e, --execode pythonSource filename
  -p, --parameter PATH   Path to parameter XML (overrides built-in default)
  -d, --datafile headname path   e.g. in the case of ./data[0-49].dat, you should set './data'. 
  -n, --numDataset number Number of dataset  e.g. in case of ./data[0-49].dat, you should set 50.
  -r, --result head of resultfilename  e.g in case of ./result/result*.dat, you should set './result/result'
  -pr RMTHRESHOLD  This is only for model1.
  -sp SPONTANEOUSPHI    This is only for model3.
  -h, --help             Show this help message

If not provided, the script uses the built-in default parameter file:
  $PARAM
EOF
}

# Parse command-line options (keeps backward compatibility)
while [[ $# -gt 0 ]]; do
  case "$1" in
    -e|--execode)
      if [[ -n "${2-}" ]]; then
          EXECODE="$2"
          shift 2
      else
          echo "Error: --execode requires a string" >&2
          exit 2
      fi
      ;;

    -p|--parameter)
      if [[ -n "${2-}" ]]; then
        PARAM="$2"
        shift 2
      else
        echo "Error: --parameter requires a value" >&2
        exit 2
      fi
      ;;

    -d|--datafile)
      if [[ -n "${2-}" ]]; then
        DATA="$2"
        shift 2
      else
        echo "Error: --datafile requires a value" >&2
        exit 2
      fi
      ;;

    -n|--numDataset)
      if [[ -n "${2-}" ]]; then
        NUM="$2"
        shift 2
      else
        echo "Error: --numDataset requires a value" >&2
        exit 2
      fi
      ;;

    -r|--result)
      if [[ -n "${2-}" ]]; then
        RESULT="$2"
        shift 2
      else
        echo "Error: --result requires a string" >&2
        exit 2
      fi
      ;;

    -h|--help)
      usage
      exit 0
      ;;

    -pr)
      if [[ -n "${2-}" ]]; then
        RMTHRESHOLD="$2"
        shift 2
      else
        echo "Error: --result requires a pruning threshold value" >&2
        exit 2
      fi
      ;;

    -sp)
      if [[ -n "${2-}" ]]; then
        SPONTANEOUSPHI="$2"
        shift 2
      else
        echo "Error: --result requires a spontaneous phi value" >&2
        exit 2
      fi
      ;;

    --) shift; break ;;
    -*) echo "Unknown option: $1" >&2; usage; exit 2 ;;
    *) break ;;
  esac
done

# throttle function: if the number of parallel jobs is larger than MAX_JOBS,  wait for a while.
throttle() {
  while [ "$(jobs -rp | wc -l)" -ge "$MAX_JOBS" ]; do
    sleep 0.2
  done
}

for ((n=0; n<NUM; n++)); do
  for i in $(seq 10 99); do
    ratio=$(awk -v x=$i 'BEGIN{printf("%.2f", x/100)}')
    case "$EXECODE" in
        "mainWorker4model2.py")
            nohup python3 "$EXECODE" --yaml "$PARAM" --data "$DATA-$n.csv" --phi "$ratio" --results "$RESULT-$ratio-$n.dat" > /dev/null 2>&1 &
            ;;
            
        "mainWorker4model1.py")
            nohup python3 "$EXECODE" --yaml "$PARAM" --data "$DATA-$n.csv" --phi "$ratio" --results "$RESULT-$ratio-$n.dat"  --rmThreshold "$RMTHRESHOLD" > /dev/null 2>&1 &
            ;;

        "mainWorker4model3.py")
            nohup python3 "$EXECODE" --yaml "$PARAM" --data "$DATA-$n.csv" --phi "$ratio" --results "$RESULT-$ratio-$n.dat"  --spontaneousPhi "$SPONTANEOUSPHI" > /dev/null 2>&1 &
            ;;
    esac
    throttle
  done
done

wait
echo "Sweep complete (0.10..0.99)"
