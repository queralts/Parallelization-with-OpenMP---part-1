#!/bin/bash
#SBATCH -N 1 # number of nodes
#SBATCH --exclusive
#SBATCH --partition=test.q

module add gcc/13.2.1

gcc -Ofast main.c common/common.c configuration/config.c layer/layer.c randomizer/randomizer.c initialize/initialize.c training/training.c -o exec -lm 

export OMP_NUM_THREADS=12

perf stat ./exec
##./exec configuration/configfile.txt
