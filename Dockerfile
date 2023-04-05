FROM ubuntu:20.04

# install pip (and python3)
RUN apt update && apt install -y python3-pip
RUN apt-get -y install git
# needed to setup time zone for installing libglib-2.0-0
ARG DEBIAN_FRONTEND=noninteractive
# dependencies required for opencv (?)
RUN apt-get update && \
    apt-get install -yq tzdata && \
    ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get install -y libglib2.0-0 libsm6 libxrender-dev libxext6
# prep conda install
RUN apt-get update && apt-get install -y build-essential && \
    apt-get install -y wget && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# install conda and set env variable (note: doesn't seem to work in container - still need to source conda in bash script)
ENV CONDA_DIR /opt/conda
ARG HOME=/home
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN chmod +x Miniconda3-latest-Linux-x86_64.sh
RUN /bin/bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda

ENV PATH=$CONDA_DIR/bin:$PATH

# copy container contents into /app
COPY . /app
WORKDIR /app

# create ldm venv for stable-diffusion repo
RUN conda env create -f environment.yaml

# download and save weights
RUN wget https://huggingface.co/CompVis/stable-diffusion-v-1-4-original/resolve/main/sd-v1-4.ckpt
RUN mkdir -p models/ldm/stable-diffusion-v1/ && \
    mv sd-v1-4.ckpt model.ckpt && \
    mv model.ckpt models/ldm/stable-diffusion-v1/

# symbolic link not working
#RUN mkdir weights && mv sd-v1-4.ckpt weights/

#RUN mkdir -p models/ldm/stable-diffusion-v1/ && \
#    ln -s weights/sd-v1-4.ckpt models/ldm/stable-diffusion-v1/model.ckpt


