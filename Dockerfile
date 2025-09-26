FROM alpine:latest

RUN mkdir /volumes

WORKDIR /app
COPY entrypoint.sh rclone-job.sh /app/
RUN chmod +x rclone-job.sh entrypoint.sh

RUN apk add --no-cache rclone tzdata bash tini

ENV RCLONE_OPTIONS="--links --progress"

# Using tini here so that crond exits properly when container is stopped
ENTRYPOINT ["tini", "--", "/app/entrypoint.sh"]