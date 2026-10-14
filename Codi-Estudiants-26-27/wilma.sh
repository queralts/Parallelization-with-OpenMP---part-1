#!/bin/bash
#SBATCH -N 1
#SBATCH --exclusive
#SBATCH --partition=nodo.q

module add gcc/13.2.1

SRC="main.c common/common.c configuration/config.c layer/layer.c randomizer/randomizer.c initialize/initialize.c training/training.c"

# ---- SEQUENTIAL ----
#gcc -Ofast -g $SRC -o exec -lm -lgomp

# ---- PARALLEL ----
gcc -Ofast -g -fopenmp $SRC -o exec -lm
export OMP_NUM_THREADS=12

#./exec
#perf stat ./exec

# ---- PER FUNCTION ----
perf record ./exec
perf report --stdio --no-children | head -40