#!/bin/bash

# check if conda is installed
if ! command -v conda >/dev/null 2>&1; then
    echo "conda is not installed. Please install conda first."
    exit 1
fi

# build conda environment
if ! conda env create -f "$HOME/manual_tomo_annotate/scripts/environment.yml"; then
    echo "Failed to create conda environment."
    exit 1
fi

# make segment.sh executable anywhere within the environment
CONDA_ENV_PATH=$(conda info --base)/envs/segment
mkdir -p "$CONDA_ENV_PATH/etc/conda/activate.d" || { echo "Failed to create activate.d directory"; exit 1; }
mkdir -p "$CONDA_ENV_PATH/etc/conda/deactivate.d" || { echo "Failed to create deactivate.d directory"; exit 1; }

# Save the original PATH and then modify it
echo 'export OLD_PATH=$PATH' > "$CONDA_ENV_PATH/etc/conda/activate.d/env_vars.sh"
echo 'export PATH=$HOME/manual_tomo_annotate/bin:$PATH' >> "$CONDA_ENV_PATH/etc/conda/activate.d/env_vars.sh"
chmod +x "$CONDA_ENV_PATH/etc/conda/activate.d/env_vars.sh" || { echo "Failed to make env_vars.sh executable"; exit 1; }

# Restore the original PATH
echo 'export PATH=$OLD_PATH' > "$CONDA_ENV_PATH/etc/conda/deactivate.d/env_vars.sh"
chmod +x "$CONDA_ENV_PATH/etc/conda/deactivate.d/env_vars.sh" || { echo "Failed to make env_vars.sh executable"; exit 1; }

# make segment script executable
chmod +x "$HOME/manual_tomo_annotate/bin/start_segment.sh" || { echo "Failed to make start_segment.sh executable"; exit 1; }

# create data directory (check if it already exists first)
if ! [ -d "$HOME/segmentation_data" ]; then
    mkdir "$HOME/segmentation_data" || { echo "Failed to create segmentation_data directory"; exit 1; }
else
    echo "Directory $HOME/segmentation_data already exists."
fi

if ! [ -d "$HOME/segmentation_data/raw_tomograms" ]; then
    mkdir "$HOME/segmentation_data/raw_tomograms" || { echo "Failed to create raw_tomograms directory"; exit 1; }
else
    echo "Directory $HOME/segmentation_data/raw_tomograms already exists."
fi

if ! [ -d "$HOME/segmentation_data/annotations" ]; then
    mkdir "$HOME/segmentation_data/annotations" || { echo "Failed to create annotations directory"; exit 1; }
else
    echo "Directory $HOME/segmentation_data/annotations already exists."
fi

# check if ITK-SNAP is installed
if ! command -v itksnap >/dev/null 2>&1; then
    echo "ITK-SNAP is not installed. Please install ITK-SNAP first."
    exit 1
fi