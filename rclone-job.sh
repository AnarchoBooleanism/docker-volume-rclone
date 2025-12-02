#!/bin/bash

volume_name_array=($VOLUME_NAMES) # Split by spaces into array

echo "Starting the task of cloning all specified Docker volumes to a remote location, \
i.e. cloning the subdirectories for each volume in \"/volumes\" to \"volumes-clone/${TARGET_SUBDIR_NAME}\"..."

for volume_name in "${volume_name_array[@]}";
do
    echo "Cloning the volume \"${volume_name}\"..."
    mkdir -p "/volumes-clone/${TARGET_SUBDIR_NAME}/${volume_name}" # Just in case
    rclone sync ${RCLONE_OPTIONS} /volumes/$volume_name "/volumes-clone/${TARGET_SUBDIR_NAME}/${volume_name}"
    echo "Finished cloning the volume \"${volume_name}\"!"
done

echo "Finished the task of cloning all specified Docker volumes to a remote location, \
i.e. cloning the subdirectories for each volume in \"/volumes\" to \"/volumes-clone/${TARGET_SUBDIR_NAME}\"!"