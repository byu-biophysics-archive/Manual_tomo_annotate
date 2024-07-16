#!/bin/sh

# check if conda is installed
if ! command -v conda >/dev/null 2>&1; then
    echo "conda is not installed. Please install conda first."
    exit 1
fi

# build conda environment
conda env create -f $HOME/manual_tomo_annotate/scripts/environment.yml

# make segment.sh executable anywhere within the environment
mkdir -p $(conda info --base)/envs/segment/etc/conda/activate.d
mkdir -p $(conda info --base)/envs/segment/etc/conda/deactivate.d

echo 'export PATH=$HOME/manual_tomo_annotate/bin:$PATH' > $(conda info --base)/envs/segment/etc/conda/activate.d/env_vars.sh
chmod +x $(conda info --base)/envs/segment/etc/conda/activate.d/env_vars.sh

echo 'unset PATH' > $(conda info --base)/envs/segment/etc/conda/deactivate.d/env_vars.sh
chmod +x $(conda info --base)/envs/segment/etc/conda/deactivate.d/env_vars.sh

# make segment script executable
chmod +x $HOME/manual_tomo_annotate/bin/segment.sh

# create data directory (check if it already exists first)
if ! [ -d $HOME/segmentation_data ]; then
    mkdir $HOME/segmentation_data
else
    echo "Directory $HOME/segmentation_data already exists."
fi

if ! [ -d $HOME/segmentation_data/raw_tomograms ]; then
    mkdir $HOME/segmentation_data/raw_tomograms
else
    echo "Directory $HOME/segmentation_data/raw_tomograms already exists."
fi

if ! [ -d $HOME/segmentation_data/annotations ]; then
    mkdir $HOME/segmentation_data/annotations
else
    echo "Directory $HOME/segmentation_data/annotations already exists."
fi

cd 

# check if ITK-SNAP is installed
if ! command -v itksnap >/dev/null 2>&1; then
    echo "ITK-SNAP is not installed. Please install ITK-SNAP first."
    exit 1
fi