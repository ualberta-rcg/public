#!/bin/bash

#SBATCH --nodes=1
#SBATCH --tasks=1
#SBATCH --mem-per-cpu=4000M
#SBATCH --gres=gpu:1

set -e

echo "Loading modules"

module load StdEnv/2020 cuda python/3.10

# Create and activate a Virtual Environment
# with libraries loaded

echo "Creating/activating virtual environment"

virtualenv --no-download $SLURM_TMPDIR/gpu-venv
source $SLURM_TMPDIR/gpu-venv/bin/activate
pip install --no-index --upgrade pip
pip install --no-index numba==0.55.1 numpy

echo "Run the python script"

python primes.py
