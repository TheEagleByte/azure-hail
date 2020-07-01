#!/usr/bin/env bash

# Upgrade hail in our hail conda environment
cd /usr/bin/anaconda/envs/hail/bin/
sudo ./python3.7 pip install 'hail==0.2.34' --force-reinstall --ignore-installed
