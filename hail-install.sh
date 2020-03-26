#!/usr/bin/env bash

# Install hail dependencies
sudo apt-get -y install g++ liblz4-dev

# Create a new python virtual environment called hail using python 3.7
sudo /usr/bin/anaconda/bin/conda create --prefix /usr/bin/anaconda/envs/hail python=3.7 anaconda --yes

# Install hail into that new environment
sudo /usr/bin/anaconda/envs/hail/bin/pip install hail
