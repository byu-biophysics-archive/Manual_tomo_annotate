#!/bin/sh

# get multiplexing shortcut
read -p "Enter your multiplexing shortcut: " username

# Check if the multiplexed connection is active
ssh -O check "$username" 2>/dev/null

# If the check command fails, establish the connection
if [ $? -ne 0 ]; then
    echo "Multiplexing connection not found. Establishing connection..."
    ssh "$username"
    if [ $? -ne 0 ]; then
        echo "Failed to establish the multiplexing connection."
        exit 1
    fi
fi

# transfer files to supercomputer
rsync -avzP "$HOME/segmentation_data/annotations/" "$username":"$HOME/groups/fslg_imagseg/nobackup/archive/segmentation_data/"

if [ $? -eq 0 ]; then
    echo "Files transferred successfully."
else
    echo "Something went wrong. Good luck."
fi