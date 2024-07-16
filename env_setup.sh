#!/bin/sh

# check if conda is installed
if ! command -v conda >/dev/null 2>&1; then
    echo "conda is not installed. Please install conda first."
    exit 1
fi

# build conda environment
conda env create -f environment.yml

# make segment.sh executable anywhere within the environment
mkdir -p $(conda info --base)/envs/segment/etc/conda/activate.d
mkdir -p $(conda info --base)/envs/segment/etc/conda/deactivate.d

echo 'export PATH=~/manual_tomo_annotate/bin:$PATH' > $(conda info --base)/envs/segment/etc/conda/activate.d/env_vars.sh
chmod +x $(conda info --base)/envs/segment/etc/conda/activate.d/env_vars.sh

echo 'unset PATH' > $(conda info --base)/envs/segment/etc/conda/deactivate.d/env_vars.sh
chmod +x $(conda info --base)/envs/segment/etc/conda/deactivate.d/env_vars.sh

# make segment script executable
chmod +x ~/manual_tomo_annotate/bin/segment.sh

# create data directory (check if it already exists first)
if ! [ -d ~/segmentation_data ]; then
    mkdir ~/segmentation_data
    cd ~/segmentation_data
else
    echo "Directory ~/segmentation_data already exists."
fi

if ! [ -d raw_tomograms]; then
    mkdir raw_tomograms
else
    echo "Directory raw_tomograms already exists."
fi

if ! [ -d annotations]; then
    mkdir annotations
else
    echo "Directory annotations already exists."
fi

cd 

# check if ITK-SNAP is installed
if ! command -v itksnap >/dev/null 2>&1; then
    echo "ITK-SNAP is not installed. Please install ITK-SNAP first."
    exit 1
fi