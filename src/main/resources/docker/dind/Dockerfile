ARG DOCKER_VERSION=18.09.6
ARG COMPOSE_VERSION=1.25.0-rc1
ARG PMC="Adrien H."

FROM docker:${DOCKER_VERSION}

MAINTAINER $PMC

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

RUN apk update
RUN apk upgrade
RUN apk add --no-cache \
		ca-certificates \
		openssl-dev \
        openssh \
        openssh-client \
		python-dev \ 
		py-pip libevent-dev libffi-dev \ 
		make \
		bash \
		git \
		curl \
        wget \
        && rm -rf /var/cache/apk/*


# RUN pip install "docker-compose${COMPOSE_VERSION:+==}${COMPOSE_VERSION}"

RUN curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION:+==}${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

RUN addgroup -S -g 1000 docker \
	&& adduser -S -G docker -u 1000 docker

## docker-entrypoint.sh from Docker-Docker-Image
##  https://github.com/docker-library/docker/tree/6001c15038b05149a83dcc17e1bbeedc92979f6d
# COPY docker-entrypoint.sh /usr/local/bin/

# ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/bin/bash"]
