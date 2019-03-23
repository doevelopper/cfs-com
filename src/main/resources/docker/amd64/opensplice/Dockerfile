# ARG BASE_IMAGE=amd64/ubuntu:16.04 ##registry access issue
# FROM $BASE_IMAGE
FROM doevelopper/foss-dds-dev:latest

USER root

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

ARG IMAGE_VERSION
ENV IMAGE_VERSION ${IMAGE_VERSION:-0.0.1}

RUN git config --global url."https://github.com/".insteadOf "git@github.com:"
RUN git config --global url."https://".insteadOf git://

ARG GSOAP_MAJOR_VERSION
ARG GSOAP_VERSION
ENV GSOAP_MAJOR_VERSION ${GSOAP_MAJOR_VERSION:-2.8}
ENV GSOAP_VERSION ${GSOAP_VERSION:-2.8.82}

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
    && make  \
    && make install \
    && cp -v ./gsoap/stdsoap2.c /usr/include \
    && cd /tmp \
    && rm -rf  gsoap-${GSOAP_MAJOR_VERSION} gsoap_${GSOAP_VERSION}.zip

ENV GSOAPHOME /usr
ENV MAVEN_OPTS $MAVEN_OPTS:"-Dhttp_proxyHost=$PROXY_HOST -Dhttp_proxyPort=$PROXY_PORT \
                           -Dhttps_proxyHost=PROXY_HOST -Dhttps_proxyPort=$PROXY_PORT \
                           -Dhttp_nonProxyHosts=localhost|127.0.0.1|localaddress|.localdomain.com|3.*|192.168.* \
                           -Dhttps_nonProxyHosts=localhost|127.0.0.1|localaddress|.localdomain.com|3.*|192.168.* \
                           -DsocksProxyHost -DsocksProxyPort"

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
ENV ACCOUNT ${ACCOUNT:-happyman}

RUN chown -R $ACCOUNT:$ACCOUNT /home/$ACCOUNT
USER $ACCOUNT

WORKDIR /home/$ACCOUNT
CMD ["/bin/bash"]

