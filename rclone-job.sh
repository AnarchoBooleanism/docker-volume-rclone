#!/bin/bash

volume_name_array=($VOLUME_NAMES) # Split by spaces into array

printf "Starting the task of cloning all specified Docker volumes to a remote location, \
i.e. cloning the subdirectories for each volume in \"/volumes\" to \"volumes-clone/%s\"...\n" \
    "${TARGET_SUBDIR_NAME}"

for volume_name in "${volume_name_array[@]}";
do
    printf 'Cloning the volume "%s"...\n' "${volume_name}"
    mkdir -p "/volumes-clone/${TARGET_SUBDIR_NAME}/${volume_name}" # Just in case
    rclone sync ${RCLONE_OPTIONS} /volumes/$volume_name "/volumes-clone/${TARGET_SUBDIR_NAME}/${volume_name}"
    printf 'Finished cloning the volume "%s"!\n' "${volume_name}"
done

printf "Finished the task of cloning all specified Docker volumes to a remote location, \
i.e. cloning the subdirectories for each volume in \"/volumes\" to \"/volumes-clone/%s\"\!\n" \
    "${TARGET_SUBDIR_NAME}"