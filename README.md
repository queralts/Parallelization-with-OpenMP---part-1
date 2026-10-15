# Parallelization of a Multi-Layer Perceptron — OpenMP

This project is part of the coursework for **Parallel Programming**, within the **Bachelor's Degree in Artificial Intelligence** at the **Universitat Autònoma de Barcelona (UAB)**, academic year 2026–2027.

The goal of the practical project is to parallelize a sequential C implementation of a neural network using different approaches and to analyse the performance of each version:

## The program

A multi-layer perceptron that recognizes handwritten digits (0–9) from 32×32 binary images of the [UCI optdigits dataset](https://archive.ics.uci.edu/dataset/80/optical+recognition+of+handwritten+digits).

- **Architecture:** 1024 → 500 → 210 → 135 → 10
- **Training:** 10 epochs, batch size 50
- **Test set:** 946 patterns

The network settings are in `configuration/configfile.txt`.

## What we parallelized

The functions `forward_prop()`, `back_prop()` and `update_weights()` in `training/training.c` are parallelized with OpenMP, splitting the neurons of each layer between threads.

## Build and run

```bash
module add gcc/13.2.1

gcc -Ofast -fopenmp main.c common/common.c configuration/config.c layer/layer.c \
    randomizer/randomizer.c initialize/initialize.c training/training.c -o exec -lm

export OMP_NUM_THREADS=12
./exec
```

On the cluster, the job is submitted with `sbatch run.sh`.

## Results

On the Wilma cluster (`new-nodo.q`) with 12 threads:

| Version | Time (s) | Speedup |
|---|---|---|
| Original sequential code | 11.87 | 1.00 |
| Our OpenMP version | 1.98 | 6.00 |

Accuracy is the same in both versions: 929 / 946 (98.2%). 

## Authors

- Queralt Salvadó Hernàndez
- Anna Blanco Illán

## Acknowledgements

The original sequential code was provided by the course teaching staff (authors: ecesar, asikora; modified by Blanca Llauradó and Christian Germer), adapted from [ML – Neural Network Implementation in C++ From Scratch](https://www.geeksforgeeks.org/ml-neural-network-implementation-in-c-from-scratch/).