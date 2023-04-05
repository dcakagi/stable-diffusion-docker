# stable-diffusion-docker
Example for running stable diffusion on the BYU supercomputer

For original Stable Diffusion repo and instructions see https://github.com/CompVis/stable-diffusion/.

## Running Instructions

First clone the repo to the supercomputer login node:
```
git clone https://github.com/dcakagi/stable-diffusion-docker.git
```
Configure the supercomputer modules/settings:
```
module load charliecloud/0.26
export LC_ALL=en_US.utf8
```
Create the Docker image: 
```
cd stable-diffusion-docker
ch-image build --force -t stablediff .
```
Build the Docker image to a tar file:
```
ch-builder2tar mytag ${HOME}
```
Make the required directories for saving models for offline use (supercomputer runs disconnected from internet):
```
mkdir ${HOME}/stablediff_outputs
mkdir ${HOME}/stablediff_model
mkdir ${HOME}/tags
```
Untar and setup the container - this will run the stable diffusion once in order to download the necessary internal models:
```
bash setup_stablediff.sh
```
Run stable diffusion on the supercomputer compute node:
```
sbatch --output ./output_results.txt --mail-user YOUR_EMAIL_HERE --job-name "stablediff" run_mytag.sh
```