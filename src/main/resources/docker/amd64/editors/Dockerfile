#docker build -t doevelopper/editors -f Dockerfile .
# expect 86m31,249s on a 16 cores
# ARG BASE_IMAGE=amd64/ubuntu:16.04 ##registry access issue
# FROM $BASE_IMAGE
FROM amd64/ubuntu:18.10

ARG PMC="Adrien H."

MAINTAINER $PMC

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

ARG IMAGE_VERSION
ENV IMAGE_VERSION ${IMAGE_VERSION:-0.0.1}

RUN apt-get -o Acquire::Check-Valid-Until="false" update --assume-yes \
    && apt-get install --assume-yes --no-install-recommends apt-transport-https ca-certificates \
        autogen  libtool autotools-dev automake \
        git xz-utils unzip wget curl openssh-server  openssh-client \
        bison flex build-essential gawk libgcrypt20-dev libcrypto++-dev \
        emacs vim tmux vim-nox texinfo \
        tree locate libxkbfile1 \
        libnotify4 libnss3 gnupg libsecret-1-0 libsecret-1-dev libxss1 libxss-dev\
#        python-pip python-dev python-wheel cython python-setuptools \
        python3-pip python3-dev cython3 python3-wheel python3-setuptools \
        perl-base perl-modules zlib1g-dev \
        libxml2-dev libxml2-utils \
        libgnutls28-dev libcurl4-gnutls-dev libgnutls-openssl27 \
        mesa-common-dev libglu1-mesa-dev libpcap-dev \
        libfontconfig libfontconfig1 libldap2-dev libldap-2.4-2  libmysql++-dev \
        unixodbc-dev libgdbm-dev libodb-pgsql-dev libcrossguid-dev  uuid-dev libossp-uuid-dev \
        libghc-uuid-dev libghc-uuid-types-dev ruby-dev libelf-dev  elfutils libelf1 \
        libpulse-dev  make nfs-common  htop \
        xvfb x11-xserver-utils x11-apps dbus gpg xauth xterm rxvt-unicode-256color iputils-ping  libswt-gtk-3-java tmux \
        libgtk2.0-0 libcanberra-gtk-module valgrind \
        #        vim-nox \
        #gdb gdbserver htop \
    && apt-get clean --assume-yes  \
    && apt-get --assume-yes --quiet clean \
    && apt-get --assume-yes --quiet autoremove \
    && rm -rvf /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/* \
    && rm -rf /usr/share/man/

#RUN apt-get update \
#    && apt-get install --assume-yes \
    #  && apt-get install -y curl dbus  \
    #     run apt-get -y --no-install-recommends install libc6-dev libgtk2.0-0 libgtk-3-0 libpango-1.0-0 \
    #     libcairo2 libfontconfig1 libgconf2-4 libnss3 libasound2 libxtst6 unzip libglib2.0-bin \
    #     libcanberra-gtk-module libgl1-mesa-glx curl build-essential gettext libstdc++6 \
    #     software-properties-common  nodejs libnotify-bin \
    #     aspell aspell-en htop emacs25 mono-complete gvfs-bin libxss1 \
    #     sudo vim libxkbfile1
#  && mkdir /var/run/dbus

RUN cd /tmp \
  && curl -o vscode-amd64.deb -L -O -k   https://go.microsoft.com/fwlink/?LinkID=760868 \
  && dpkg -i vscode-amd64.deb \
  &&  rm vscode-amd64.deb

ARG ACCOUNT=developer
RUN useradd -ms /bin/bash $ACCOUNT
RUN chown -R $ACCOUNT:$ACCOUNT /home/$ACCOUNT
USER $ACCOUNT
WORKDIR /home/$ACCOUNT

RUN cd /tmp \
  && /usr/bin/code --install-extension yzhang.markdown-all-in-one \
  && /usr/bin/code --install-extension eamodio.gitlens \
  && /usr/bin/code --install-extension goessner.mdmath \
  && /usr/bin/code --install-extension idleberg.badges \
  && /usr/bin/code --install-extension ms-python.python \
  && /usr/bin/code --install-extension ms-vscode.cpptools \
  && /usr/bin/code --install-extension sandy081.todotasks \
  && /usr/bin/code --install-extension azemoh.one-monokai \
  && /usr/bin/code --install-extension dracula-theme.theme-dracula \
  && /usr/bin/code --install-extension IBM.output-colorizer \
  && /usr/bin/code --install-extension ms-vscode.github-issues-prs \
  && /usr/bin/code --install-extension PKief.material-icon-theme \
  && /usr/bin/code --install-extension VisualStudioExptTeam.vscodeintellicode \
  && /usr/bin/code --install-extension alexdima.copy-relative-path \
  && /usr/bin/code --install-extension cssho.vscode-svgviewer \
  && /usr/bin/code --install-extension ms-vscode.Go \
  && /usr/bin/code --install-extension PeterJausovec.vscode-docker \
  && /usr/bin/code --install-extension GitHub.vscode-pull-request-github \
  && /usr/bin/code --install-extension ms-vscode.Theme-1337 \
  && /usr/bin/code --install-extension ms-vscode.Theme-TomorrowKit \
  && /usr/bin/code --install-extension vector-of-bool.gitflow \
  && /usr/bin/code --install-extension alefragnani.project-manager  \
  && /usr/bin/code --install-extension alexkrechik.cucumberautocomplete \
  && /usr/bin/code --install-extension AravindKumar.gherkin-indent \
  && /usr/bin/code --install-extension austin.code-gnu-global \
  && /usr/bin/code --install-extension BazelBuild.vscode-bazel \
  && /usr/bin/code --install-extension bbenoist.Doxygen \
  && /usr/bin/code --install-extension cheshirekow.cmake-format \
  && /usr/bin/code --install-extension CoenraadS.bracket-pair-colorizer \
  && /usr/bin/code --install-extension cschlosser.doxdocgen \
  && /usr/bin/code --install-extension DavidAnson.vscode-markdownlint \
  && /usr/bin/code --install-extension dbankier.vscode-instant-markdown \
  && /usr/bin/code --install-extension donjayamanne.githistory \
  && /usr/bin/code --install-extension DotJoshJohnson.xml \
  && /usr/bin/code --install-extension doublefint.pgsql \
  && /usr/bin/code --install-extension EFanZh.graphviz-preview \
  && /usr/bin/code --install-extension fabianlauer.vs-code-xml-format \
  && /usr/bin/code --install-extension formulahendry.auto-close-tag \
  && /usr/bin/code --install-extension formulahendry.code-runner \
  && /usr/bin/code --install-extension formulahendry.terminal \
  && /usr/bin/code --install-extension GreatMinds.gitflow4code \
  && /usr/bin/code --install-extension hangxingliu.vscode-nginx-conf-hint \
  && /usr/bin/code --install-extension HookyQR.beautify \
  && /usr/bin/code --install-extension ilevine.squash \
  && /usr/bin/code --install-extension jbenden.c-cpp-flylint \
  && /usr/bin/code --install-extension jebbs.plantuml \
  && /usr/bin/code --install-extension joelday.docthis \
  && /usr/bin/code --install-extension LaurentTreguier.uncrustify \
  && /usr/bin/code --install-extension liximomo.sftp \
  && /usr/bin/code --install-extension maddouri.cmake-tools-helper \
  && /usr/bin/code --install-extension mathiasfrohlich.Kotlin \
  && /usr/bin/code --install-extension mitaki28.vscode-clang \
  && /usr/bin/code --install-extension mohsen1.prettify-json \
  && /usr/bin/code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools \
  && /usr/bin/code --install-extension ms-vscode.notepadplusplus-keybindings \
  && /usr/bin/code --install-extension ms-vscode.PowerShell \
  && /usr/bin/code --install-extension ms-vscode.Theme-MaterialKit \
  && /usr/bin/code --install-extension rashwell.tcl \
  && /usr/bin/code --install-extension rebornix.ruby \
  && /usr/bin/code --install-extension redhat.java \
  && /usr/bin/code --install-extension redhat.vscode-yaml \
  && /usr/bin/code --install-extension satokaz.vscode-toggleproxy \
  && /usr/bin/code --install-extension secanis.jenkinsfile-support \
  && /usr/bin/code --install-extension shanoor.vscode-nginx \
  && /usr/bin/code --install-extension sidneys1.gitconfig \
  && /usr/bin/code --install-extension sleutho.tcl \
  && /usr/bin/code --install-extension Stephanvs.dot \
  && /usr/bin/code --install-extension stevejpurves.cucumber  \
  && /usr/bin/code --install-extension tht13.python  \
  && /usr/bin/code --install-extension tuxtina.json2yaml \
  && /usr/bin/code --install-extension twxs.cmake \
  && /usr/bin/code --install-extension vangware.dark-plus-material \
  && /usr/bin/code --install-extension vector-of-bool.cmake-tools \
  && /usr/bin/code --install-extension vscjava.vscode-maven \
  && /usr/bin/code --install-extension vscodevim.vim \
  && /usr/bin/code --install-extension wayou.vscode-todo-highlight \
  && /usr/bin/code --install-extension wlhe.c-cpp-snippets \
  && /usr/bin/code --install-extension ziyasal.vscode-open-in-github \
  && /usr/bin/code --install-extension zxh404.vscode-proto3 \
  && /usr/bin/code --install-extension CT6502.idl

USER root


ENV ECLIPSE_CPP_DOWNLOAD_URL https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/2019-03/R/eclipse-cpp-2019-03-R-linux-gtk-x86_64.tar.gz

RUN cd /tmp \
  && curl -L -O -k "https://mirrors.dotsrc.org/eclipse//technology/epp/downloads/release/2019-03/R/eclipse-cpp-2019-03-R-linux-gtk-x86_64.tar.gz" | tar xz -C /opt \
  && ln -s /opt/eclipse/eclipse /usr/bin/ \
  && chown -R $ACCOUNT:$ACCOUNT /opt/eclipse \
  && chmod -R 775 /opt/eclipse

RUN echo "ForwardX11Trusted yes" >> /etc/ssh/sshd_config
RUN echo "X11UseLocalhost no" >> /etc/ssh/sshd_config

USER $ACCOUNT
ENTRYPOINT /usr/bin/code --version
CMD ["/bin/bash"]


# docker run --rm -ti e "DISPLAY=$DISPLAY" --volume  /tmp/.X11-unix:/tmp/.X11-unix  -e HOST_PERMS="$(id -u):$(id -g)" --volume "${HOME}/.conan:/home/happyman/.conan" --volume ${HOME}/.vimrc:/home/happyman/.vim --volume ${HOME}/.vimrc:/home/happyman/.vimrc --volume ${HOME}/.bashrc:/home/happyman/.bashrc  registry.gear.ge.com/100034251/rti-dds:latest --volume "$PWD:/home/happyman/workspace"
