# docker-volume-rclone
A solution for regularly cloning Docker volumes to a remote NFS location.

Much of this was possible thanks to [this guide written by Jason Kulatunga, aka Sparktree](https://blog.thesparktree.com/cron-in-docker).

## Important environment variables to set
- `TARGET_SUBDIR_NAME` - The name of the subdirectory within the target directory to clone to.
- `VOLUME_NAMES` - The list of names of volumes to clone to the remote location, separated by spaces. Each volume is cloned to a subdirectory within `/volumes-clone`, named after the name of the volume.
- `RUN_ON_STARTUP` (optional) - Whether to run the rclone job when the container is started. If set to `true`, then it runs on startup.
- `CRON_ARGUMENTS` (optional) - In [cron format](https://www.ibm.com/docs/en/db2-as-a-service?topic=task-unix-cron-format), being minute, hour, day of month, month, day of week. If not set, then no cron job will be scheduled.
- `RCLONE_OPTIONS` (optional) - A list of [options to set](https://rclone.org/commands/rclone_sync/#options) when running `rclone sync`. If not set, then it defaults to `--links --progress`
- `TZ` (optional) - The [timezone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) to set for the container (e.g. `America/Los_Angeles`). 

## Important mounts to map volumes to
- `/volumes` - This is the contents of `/var/lib/docker/volumes`, where Docker volumes are located. It is recommended to make this read-only.
- `/volumes-clone` - This is where the specified contents of `/volumes` get cloned to, like a local directory or NFS mount. (See `compose.yaml` for example)