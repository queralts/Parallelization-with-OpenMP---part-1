#!/bin/bash
#SBATCH -N 1 # number of nodes
#SBATCH --exclusive
#SBATCH --partition=test.q

module add gcc/13.2.1

# ---- SEQUENTIAL ----
#gcc -Ofast -g $SRC -o exec -lm -lgomp

# ---- PARALLEL ----
gcc -Ofast -g -fopenmp $SRC -o exec -lm
export OMP_NUM_THREADS=2


export OMP_NUM_THREADS=12

perf stat ./exec
##./exec configuration/configfile.txt
