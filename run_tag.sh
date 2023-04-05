#!/bin/bash

#SBATCH --time=1:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --gpus=1
#SBATCH --mem-per-cpu=64000M
#SBATCH --qos=cs
#SBATCH --partition=cs

set -e
set -u

module load charliecloud/0.26

# load GPU driver and mount container
module load libnvidia-container
ch-fromhost --nvidia ~/tags/stablediff/

# run stable diffusion
ch-run \
-w \
--no-home \
-b ${HOME}/stablediff_outputs:/app/outputs \
-b ${HOME}/stablediff_model:/app/downloaded_model \
-c /app \
~/tags/stablediff/ -- \
./run_stablediff.sh
