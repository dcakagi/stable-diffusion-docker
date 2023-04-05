#!/bin/bash

source /opt/conda/etc/profile.d/conda.sh
conda activate ldm
python3 scripts/txt2img.py --prompt "a photograph of an underwater car being driven by a fish" --plms
