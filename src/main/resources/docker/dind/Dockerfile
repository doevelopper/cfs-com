#        cfs-com/src/main/resources/docker/dind/Dockerfile
#
#               Copyright (c) 2014-2018 A.H.L
#
#        Permission is hereby granted, free of charge, to any person obtaining
#        a copy of this software and associated documentation files (the
#        "Software"), to deal in the Software without restriction, including
#        without limitation the rights to use, copy, modify, merge, publish,
#        distribute, sublicense, and/or sell copies of the Software, and to
#        permit persons to whom the Software is furnished to do so, subject to
#        the following conditions:
#
#        The above copyright notice and this permission notice shall be
#        included in all copies or substantial portions of the Software.
#
#        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#        EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#        MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
#        NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
#        LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
#        OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
#        WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

ARG BASE_IMAGE=amd64/ubuntu:19.04
FROM ${BASE_IMAGE}

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

RUN apt-get update \
    && apt-get install curl git make wget locales git-flow\ 
        software-properties-common apt-transport-https ca-certificates \ 
        gnupg2 lsb-release --assume-yes \
    && curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add - \
    && add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" \
    && apt-get update \
    && apt-get install docker-ce docker-ce-cli containerd.io --assume-yes\
    && apt-get autoremove --assume-yes \
    && apt-get clean --assume-yes \
    && rm -rf /var/lib/apt/lists/*

RUN curl -k -L https://github.com/docker/compose/releases/download/1.24.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose \
    && docker-compose --version


# # Install Kubectl
# Note: Latest version of kubectl may be found at:
# https://aur.archlinux.org/packages/kubectl-bin/
ENV KUBE_LATEST_VERSION="v1.15.0"
RUN \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \ 
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl

# # Install helm
# Note: Latest version of helm may be found at:
# https://github.com/kubernetes/helm/releases
ENV HELM_VERSION="v2.14.3"
RUN wget -q https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm

CMD ["/bin/bash"]
