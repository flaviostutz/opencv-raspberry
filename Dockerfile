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
           wget unzip

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

CMD ["service ssh start"]

EXPOSE 22
