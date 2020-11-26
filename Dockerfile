FROM cimg/php:7.3.11
USER root

# Set env vars
ENV container docker
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

# update, upgrade, dependencies and cleanup
RUN apt-get update && apt-get upgrade -qy && apt-get install -qy \
    apt-utils \
    curl \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# install php-sqllint
RUN mkdir /opt/lint && \
    curl --location https://github.com/cweiske/php-sqllint/releases/download/v0.2.3/php-sqllint-0.2.3.phar --output /opt/lint/php-sqllint.phar && \
    phar extract -f /opt/lint/php-sqllint.phar /opt/lint && \
    ln -s /opt/lint/bin/php-sqllint /usr/local/bin/php-sqllint && \
    chmod +x /usr/local/bin/php-sqllint

# php-sqllint script
COPY lint.sh /opt/lint.sh

# finally run script on startup
CMD ["/bin/bash"]
