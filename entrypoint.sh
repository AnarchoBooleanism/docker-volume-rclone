#!/bin/bash

env >> /etc/environment # Important for cronjobs running correctly

# Exit when TARGET_SUBDIR_NAME is blank
if [[ -z $TARGET_SUBDIR_NAME ]]; then
    printf "TARGET_SUBDIR_NAME must be set for this container to run properly.\n" >&2
    exit 1
fi

# If RUN_ON_STARTUP, then do it now
if [[ $RUN_ON_STARTUP == "true" ]]; then
    printf "Currently in startup, now performing rclone as requested...\n"
    /app/rclone-job.sh
fi

# If CRON_ARGUMENTS, then write to cron and do the things needed to activate it

if [[ -n $CRON_ARGUMENTS ]]; then
    printf "As CRON_ARGUMENTS is not blank, now creating a cronjob...\n"
    mkdir -p /etc/cron.d
    CRON_JOB_LINE="${CRON_ARGUMENTS} /app/rclone-job.sh"
    printf "%s\n" "${CRON_JOB_LINE}" >> /etc/crontabs/root
    printf 'Added "%s" to crontabs list.\n' "${CRON_JOB_LINE}"
    exec crond -f -l 2
fi