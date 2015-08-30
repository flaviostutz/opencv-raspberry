FROM resin/rpi-raspbian:wheezy

RUN apt-get update \
      && apt-get -y install build-essential cmake cmake-curses-gui \
           pkg-config libpng12-0 libpng12-dev libpng++-dev \
           libpng3 libpnglite-dev zlib1g-dbg zlib1g zlib1g-dev \
           pngtools libtiff4-dev libtiff4 libtiffxx0c2 libtiff-tools libeigen3-dev \
           libjpeg8 libjpeg8-dev libjpeg8-dbg libjpeg-progs \
           ffmpeg libavcodec-dev libavcodec53 libavformat53 \
           libavformat-dev libxine1-ffmpeg libxine-dev libxine1-bin \
           libunicap2 libunicap2-dev swig libv4l-0 libv4l-dev \
           python-numpy libpython2.6 python-dev python2.6-dev libgtk2.0-dev \
           wget unzip ssh openssh-server

RUN cd /opt \
     && wget https://github.com/Itseez/opencv/archive/3.0.0.zip \
     && unzip 3.0.0.zip \
     && cd opencv-3.0.0 \
     && mkdir release \
     && cd release \
     && cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D BUILD_NEW_PYTHON_SUPPORT=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON  -D BUILD_EXAMPLES=ON .. \
     && make -j4 \
     && make install \
     && ldconfig

RUN mkdir /var/run/sshd \
    && echo 'root:root' | chpasswd \
    && sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/ss$
    && echo "export VISIBLE=now" >> /etc/profile

# SSH login fix. Otherwise user is kicked off after login
#RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g$

ENV NOTVISIBLE "in users profile"

CMD ["/usr/sbin/sshd", "-D"]

EXPOSE 22
