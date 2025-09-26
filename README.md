# docker-volume-rclone
A solution for regularly cloning Docker volumes to a remote NFS location.

Much of this was possible thanks to [this guide written by Jason Kulatunga, aka Sparktree](https://blog.thesparktree.com/cron-in-docker).

## Important environment variables to set
- `TARGET_SUBDIR_NAME` - The name of the subdirectory within the target directory to clone to.
- `RUN_ON_STARTUP` (optional) - Whether to run the rclone job when the container is started. If set to `TRUE`, then it runs on startup.
- `CRON_ARGUMENTS` (optional) - In [cron format](https://www.ibm.com/docs/en/db2-as-a-service?topic=task-unix-cron-format), being minute, hour, day of month, month, day of week. If not set, then no cron job will be scheduled.
- `RCLONE_OPTIONS` (optional) - A list of [options to set](https://rclone.org/commands/rclone_sync/#options) when running `rclone sync`. If not set, then it defaults to `--links --progress`
- `TZ` (optional) - The timezone to set for the container. Example: `America/Los_Angeles`

## Important mounts to map volumes to
- `/volumes` - It's recommended that you map individual volumes to subdirectories of this mount, rather than Docker's volumes folder to this mount (to avoid an infinite loop). It is recommended to make these read-only.
- `/volumes-clone` - This is where `/volumes` gets cloned to, like a local directory or NFS mount. (See `docker-compose.yml` for example)