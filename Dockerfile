# mysql backup image
FROM alpine:3.9
MAINTAINER Avi Deitcher <https://github.com/deitch>

ENV PATH $PATH:/usr/local/bin/google-cloud-sdk/bin

# install the necessary client
RUN apk add --no-cache --update 'mariadb-client>10.3.15' mariadb-connector-c curl bash python3 shadow && \
    pip3 install awscli \
    && curl -sSL https://sdk.cloud.google.com | bash -s -- --install-dir=/usr/local/bin


# set us up to run as non-root user
RUN groupadd -g 1005 appuser && \
    useradd -r -u 1005 -g appuser appuser

# install the entrypoint
COPY functions.sh /
COPY entrypoint /entrypoint

# start
ENTRYPOINT ["/entrypoint"]
