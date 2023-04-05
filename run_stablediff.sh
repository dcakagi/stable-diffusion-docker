#!/bin/bash

source /opt/conda/etc/profile.d/conda.sh
conda activate ldm
python3 scripts/txt2img.py --prompt "kids swimming in a fish tank" --plms
