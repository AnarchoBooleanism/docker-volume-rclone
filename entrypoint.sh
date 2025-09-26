#!/bin/bash

env >> /etc/environment # Important for cronjobs running correctly

# Exit when TARGET_SUBDIR_NAME is blank
if [[ -z $TARGET_SUBDIR_NAME ]]; then
    echo "TARGET_SUBDIR_NAME must be set for this container to run properly." >&2
    exit 1
fi

# If RUN_ON_STARTUP, then do it now
if [[ $RUN_ON_STARTUP == "TRUE" ]]; then
    echo "Currently in startup, now performing rclone as requested..."
    /app/rclone-job.sh
fi

# If CRON_ARGUMENTS, then write to cron and do the things needed to activate it

if [[ -n $CRON_ARGUMENTS ]]; then
    echo "As CRON_ARGUMENTS is not blank, now creating a cronjob..."
    mkdir -p /etc/cron.d
    CRON_JOB_LINE="$CRON_ARGUMENTS /app/rclone-job.sh"
    echo "$CRON_JOB_LINE" >> /etc/crontabs/root
    echo "Added \"$CRON_JOB_LINE\" to crontabs list."
    exec crond -f -l 2
fi