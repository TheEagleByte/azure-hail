#!/usr/bin/env bash

# Upgrade hail in our hail conda environment
sudo /usr/bin/anaconda/envs/hail/bin/pip install 'hail==0.2.39' --force-reinstall
