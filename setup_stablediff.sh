#!/bin/bash

set -e
set -u

module load charliecloud/0.26
module load libnvidia-container

ch-tar2dir ${HOME}/stablediff.tar.gz ${HOME}/tags

# need to mount container in order to download/run initial stable diffusion
ch-fromhost --nvidia ~/tags/stablediff/

chmod a+rwx ~/tags/stablediff/app/download_models.sh
chmod a+rwx ~/tags/stablediff/app/run_stablediff.sh

ch-run \
-w \
--no-home \
-b ${HOME}/stablediff_outputs:/app/outputs \
-b ${HOME}/stablediff_model:/app/downloaded_model \
-c /app \
~/tags/stablediff/ -- \
./download_models.sh
