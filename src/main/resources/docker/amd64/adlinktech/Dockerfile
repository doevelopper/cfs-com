#        cfs-com/src/main/resources/docker/amd64/omg/Dockerfile
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
# 

ARG BASE_IMAGE=docker.io/doevelopper/cfs-com-dev:0.0.1
FROM $BASE_IMAGE 

USER root

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

ARG IMAGE_VERSION
ENV IMAGE_VERSION ${IMAGE_VERSION:-0.0.1}

ARG OSPL_RELEASE 
ENV OSPL_RELEASE ${OSPL_RELEASE:-6.9} 

RUN git config --global url."https://github.com/".insteadOf "git@github.com:"
RUN git config --global url."https://".insteadOf git://

ARG GSOAP_MAJOR_VERSION
ARG GSOAP_VERSION
ENV GSOAP_MAJOR_VERSION ${GSOAP_MAJOR_VERSION:-2.8}
ENV GSOAP_VERSION ${GSOAP_VERSION:-2.8.89}

ENV PROTOBUF_HOME /usr

# https://www.genivia.com/downloads.html
# Do not use paralle build... fails
RUN cd /tmp \
#    && curl -L -O -k https://freefr.dl.sourceforge.net/project/gsoap2/gsoap-${GSOAP_MAJOR_VERSION}/gsoap_${GSOAP_VERSION}.zip  \
    && curl -L -O -k https://sources.voidlinux.org/gsoap-${GSOAP_VERSION}/gsoap_${GSOAP_VERSION}.zip \
    && unzip gsoap_${GSOAP_VERSION}.zip \
    && cd gsoap-${GSOAP_MAJOR_VERSION} \
#    && ./configure --enable-samples --with-openssl=/usr --with-zlib=/usr --prefix=/usr/ \
    && ./configure --with-openssl=/usr --with-zlib=/usr --prefix=/usr/ \
    && make clean \
    && cp -v ./gsoap/stdsoap2.c /usr/include \
    && make  \
    && make install \
    && cd /tmp \
    && rm -rf  gsoap-${GSOAP_MAJOR_VERSION} gsoap_${GSOAP_VERSION}.zip

ENV GSOAPHOME /usr

RUN cd /tmp \
    && wget --no-check-certificate https://www.jacorb.org/releases/2.3.1/jacorb-2.3.1-bin.zip \
    && unzip jacorb-2.3.1-bin.zip \
    && mv -v jacorb-2.3.1 /opt/ \
    && rm -rf jacorb-2.3.1-bin.zip

ENV JACORB_HOME /opt/jacorb-2.3.1

RUN cd /tmp \
    && git clone --depth=1 --recurse-submodules  https://github.com/ADLINK-IST/opensplice.git \
    && cd opensplice \
    && ./configure x86_64.linux-release --prefix=/usr/local \
    && chmod +x  ./envs-x86_64.linux-release.sh \
    #    && /bin/bash -c "source envs-x86_64.linux-release.sh" \
    && . ./envs-x86_64.linux-release.sh \
    && make \
    && make install \
    && cp -Rv install/HDE /opt/ \
    && cp -Rv install/RTS /opt/ \
    && cd /tmp \
    && rm -rf opensplice

ARG ACCOUNT
ENV ACCOUNT ${ACCOUNT:-developer}
RUN chown -R $ACCOUNT:$ACCOUNT /home/$ACCOUNT
USER $ACCOUNT
WORKDIR /home/$ACCOUNT
CMD ["/bin/bash"]
