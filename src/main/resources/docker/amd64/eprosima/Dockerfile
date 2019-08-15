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

# Java
#RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
#RUN add-apt-repository ppa:webupd8team/java
#RUN apt-get update
#RUN apt-get install -y oracle-java8-installer
#RUN rm -rf /var/cache/oracle-jdk8-installer


RUN cd /tmp \
    && git clone --depth=1 --recurse-submodules https://github.com/eProsima/Fast-RTPS.git \
    && cd Fast-RTPS \
    && cmake -E make_directory build \
    && cmake -E chdir build cmake .. -DTHIRDPARTY=ON -DPERFORMANCE_TESTS=ON -DCMAKE_INSTALL_PREFIX=/usr/eprosima \
    && cmake --build build --target all --clean-first -- -j `nproc` \
    && cmake --build build --target install \
    && cd /tmp \
    && rm -rf Fast-RTPS

# Clone and install Micro XRCE-DDS Agent
#RUN git clone https://github.com/eProsima/Micro-XRCE-DDS-Agent.git agent \
#    && mkdir agent/build && cd agent/build \
#    && cmake -DTHIRDPARTY=ON -DVERBOSE=ON .. \
#    && make -j `nproc` install

ARG ACCOUNT
ENV ACCOUNT ${ACCOUNT:-developer}
RUN chown -R $ACCOUNT:$ACCOUNT /home/$ACCOUNT
USER $ACCOUNT
WORKDIR /home/$ACCOUNT
CMD ["/bin/bash"]
