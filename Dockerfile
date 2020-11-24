FROM ubuntu:20.04

# Set env vars
ENV container docker
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

# configure apt behaviour
RUN echo "APT::Get::Install-Recommends 'false'; \n\
    APT::Get::Install-Suggests 'false'; \n\
    APT::Get::Assume-Yes 'true'; \n\
    APT::Get::force-yes 'true';" > /etc/apt/apt.conf.d/00-general

# update and upgrade
RUN apt-get update && \
    apt-get upgrade -qy && \
    apt-get install -qy apt-utils 

# install dependencies for php-sqllint
RUN apt-get install -qy \
    php \
    wget

# install php-sqllint
RUN mkdir /opt/lint && \
    wget https://github.com/cweiske/php-sqllint/releases/download/v0.2.3/php-sqllint-0.2.3.phar --output-document=/opt/lint/php-sqllint.phar && \
    phar extract -f /opt/lint/php-sqllint.phar /opt/lint && \
    ln -s /opt/lint/bin/php-sqllint /usr/local/bin/php-sqllint && \
    chmod +x /usr/local/bin/php-sqllint

# cleanup
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# php-sqllint script
RUN echo '#!/bin/bash \n\
destination=${1:-.} \n\
! find $destination -type f -iname "*.sql" -not -path "*-no-lint.sql" -exec php-sqllint {} \; | grep . \n\
' > /opt/lint.sh

# finally run script on startup
CMD ["/bin/bash"]
