#!/bin/bash

source /opt/conda/etc/profile.d/conda.sh
conda activate ldm

# download stable diffusion model and save for offline use
python3 download_models.py

# run txt2img once while online to download and cache required internal models
python3 scripts/txt2img.py --prompt "an engineering student sleeping while doing homework"
