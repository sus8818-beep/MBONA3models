#!/bin/bash

WORKDIR=../results
model=0
model=$1
additionalName=$2

if [ -z "$model" ]; then
    echo "Usage: $0 <model-number> <optional: additional name>"
    exit 1
fi

cd $WORKDIR
for p in $(seq 0.1 0.1 0.9); do
    ### extract archive file 
    if [ -z "$additionalName" ]; then
        target="results-model${model}-$p-0.5"
    else
        target="results-model${model}-$p-0.5-${additionalName}"
    fi
    tar -xzvf "${target}.tgz"


    ### collecting the last lines for each shrink ratio
    final_out="${target}_summary.txt"
    final_archive="${target}_final_summary.tgz"
    echo "# s mean lower upper" > "$final_out"

    ### make final_out ###
    for s in $(seq 0.10 0.01 0.99); do

        out="model${model}_p${p}_s${s}_summary.txt"

        ### make a tmpfile for building out
        tmpfile=$(mktemp)

        awk -v model="$model" -v p="$p" -v s="$s" '
        BEGIN {
            fileidx = 0
            nvar = 50
        }

        {
            err = $1
            data[FNR, fileidx] = err
        }

        FNR==1 { fileidx++ }

        END {
            for (line=1; line<=FNR; line++) {
                sum = 0
                for (i=0; i<nvar; i++) sum += data[line, i]
                mean = sum / nvar

                var = 0
                for (i=0; i<nvar; i++) var += (data[line, i] - mean)^2
                var /= (nvar - 1)

                se = sqrt(var / nvar)
                ci = 1.96 * se

                printf("%d %.6f %.6f %.6f\n", line, mean, mean-ci, mean+ci)
            }
       }
       ' $(for v in $(seq 0 49); do printf "model${model}result${p}-0.5-${s}-${v}.dat "; done) \
       > "$tmpfile"

       ### extract final line
       last_line=$(tail -n 1 "$tmpfile")

       mean=$(echo "$last_line" | awk '{print $2}')
       lower=$(echo "$last_line" | awk '{print $3}')
       upper=$(echo "$last_line" | awk '{print $4}')

       ### append the data to final_summary
       printf "%.2f %.6f %.6f %.6f\n" "$s" "$mean" "$lower" "$upper" >> "$final_out"

       ### store tmpfile as out
       mv "$tmpfile" "$out"

    done
    tar -czvf ${final_archive} *.txt
    \rm *.dat
    \rm *.txt
done
cd -
