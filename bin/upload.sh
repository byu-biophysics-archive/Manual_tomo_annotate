#!/bin/sh

# get multiplexing shortcut
read -p "Enter your supercomputer username: " username
read -sp "Enter your supercomputer password: " password
read -p "Enter your supercomputer 2FA code: " twofactor

# # Check if the multiplexed connection is active
# ssh -O check "$username" 2>/dev/null

# # If the check command fails, establish the connection
# if [ $? -ne 0 ]; then
#     echo "Multiplexing connection not found. Establishing connection..."
#     ssh "$username"
#     if [ $? -ne 0 ]; then
#         echo "Failed to establish the multiplexing connection."
#         exit 1
#     fi
# fi

# transfer files to supercomputer
expect << EOF
spawn rsync -avzP "$HOME/segmentation_data/annotations/" "$username"@ssh.rc.byu.edu:"$HOME/groups/fslg_imagseg/nobackup/archive/segmentation_data/"
expect "Password:"
send "$password\r"
expect "Verification code:"
send "$twofactor\r"
expect eof
EOF

if [ $? -eq 0 ]; then
    echo "Files transferred successfully."
else
    echo "Something went wrong. Good luck."
fi