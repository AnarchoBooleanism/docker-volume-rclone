#!/bin/bash

echo "Cloning \"/volumes\" to \"/volumes-clone/$TARGET_SUBDIR_NAME\"..."
mkdir -p "/volumes-clone/$TARGET_SUBDIR_NAME" # Just in case
rclone sync $RCLONE_OPTIONS /volumes "/volumes-clone/$TARGET_SUBDIR_NAME"
echo "Finished cloning \"/volumes\" to \"/volumes-clone/$TARGET_SUBDIR_NAME!\""