ARG DOCKER_VERSION=18.09.6
ARG COMPOSE_VERSION=1.25.0-rc1
ARG PMC="Adrien H."

FROM docker:${DOCKER_VERSION}

MAINTAINER $PMC

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

RUN apk update \
	&& 	apk upgrade \
	&& 	apk add --no-cache \
		ca-certificates \
		openssl-dev \
		openssh \
		openssh-client \
		python-dev \ 
		py-pip \
		make \
		bash \
		git \
		curl \
		wget \
		rsync \
		tar \
		gzip \
		zip \
		vim \
		jq \
		findutils \
		which \
        && rm -rf /var/cache/apk/*


# RUN pip install "docker-compose${COMPOSE_VERSION:+==}${COMPOSE_VERSION}"

# RUN \
#     curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
#     add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
#     apt-get update && \
#     apt-get install -y docker-ce docker-ce-cli containerd.io

# # Install docker-compose
# RUN \
#     curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
#     chmod +x /usr/local/bin/docker-compose && \
#     ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# # Install Kubectl
# RUN \
#     curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
#     chmod +x ./kubectl && \
#     mv ./kubectl /usr/local/bin/kubectl

RUN curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION:+==}${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

RUN addgroup -S -g 1000 docker \
	&& adduser -S -G docker -u 1000 docker

## docker-entrypoint.sh from Docker-Docker-Image
##  https://github.com/docker-library/docker/tree/6001c15038b05149a83dcc17e1bbeedc92979f6d
# COPY docker-entrypoint.sh /usr/local/bin/

# ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/bin/bash"]
