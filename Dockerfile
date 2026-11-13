FROM alpine:3.24.4@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf

# To be passed from Github Actions
ARG GIT_VERSION_TAG=unspecified
ARG GIT_COMMIT_MESSAGE=unspecified
ARG GIT_VERSION_HASH=unspecified

RUN mkdir /volumes

WORKDIR /app

# Write any Git-related info
RUN printf "%s\n" "$GIT_VERSION_TAG" > GIT_VERSION_TAG.txt
RUN printf "%s\n" "$GIT_COMMIT_MESSAGE" > GIT_COMMIT_MESSAGE.txt
RUN printf "%s\n" "$GIT_VERSION_HASH" > GIT_VERSION_HASH.txt

# Copy over important files
COPY entrypoint.sh rclone-job.sh /app/
RUN chmod +x rclone-job.sh entrypoint.sh

RUN apk add --no-cache rclone tzdata bash tini

ENV RCLONE_OPTIONS="--links --progress"

# Using tini here so that crond exits properly when container is stopped
ENTRYPOINT ["tini", "--", "/app/entrypoint.sh"]