#!/bin/bash
#SBATCH --nodes=1
#SBATCH --gpus-per-node=4       # Request GPU "generic resources"
#SBATCH --cpus-per-task=2  # Refer to cluster's documentation for the right CPU/GPU ratio
#SBATCH --mem=510000M       # Memory proportional to GPUs: 32000 Cedar, 47000 Béluga, 64000 Graham.
#SBATCH --time=0-12:00     # DD-HH:MM:SS
#SBATCH --mail-user=allar145@ulaval.ca
#SBATCH --mail-type=ALL

cp -r edm_data $SLURM_TMPDIR
cp -r dataset-data $SLURM_TMPDIR

module purge --force
module load StdEnv/2020
module load python/3.10
# module load cuda cudnn
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --no-index --upgrade pip
pip install --no-index -r requirements.txt

python train-wa.py
