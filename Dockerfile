FROM alpine:3.23.0

# To be passed from Github Actions
ARG GIT_VERSION_TAG=unspecified
ARG GIT_COMMIT_MESSAGE=unspecified
ARG GIT_VERSION_HASH=unspecified

RUN mkdir /volumes

WORKDIR /app

# Write any Git-related info
RUN echo $GIT_VERSION_TAG > GIT_VERSION_TAG.txt
RUN echo $GIT_COMMIT_MESSAGE > GIT_COMMIT_MESSAGE.txt
RUN echo $GIT_VERSION_HASH > GIT_VERSION_HASH.txt

# Copy over important files
COPY entrypoint.sh rclone-job.sh /app/
RUN chmod +x rclone-job.sh entrypoint.sh

RUN apk add --no-cache rclone tzdata bash tini

ENV RCLONE_OPTIONS="--links --progress"

# Using tini here so that crond exits properly when container is stopped
ENTRYPOINT ["tini", "--", "/app/entrypoint.sh"]