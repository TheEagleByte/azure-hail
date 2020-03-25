#!/usr/bin/env bash

# Set Jupyter Notebook to allow use of this hail environment
sudo sed -i '/python3_executable_path/c\ \"python3_executable_path\" : \"/usr/bin/anaconda/envs/hail/bin/python3\"' /home/spark/.sparkmagic/config.json
