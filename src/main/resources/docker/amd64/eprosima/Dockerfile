# ARG BASE_IMAGE=amd64/ubuntu:16.04 ##registry access issue
# FROM $BASE_IMAGE
FROM registry.gear.ge.com/100034251/omg-dds




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

USER $ACCOUNT

WORKDIR /home/$ACCOUNT
CMD ["/bin/bash"]

