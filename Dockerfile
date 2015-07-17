FROM ipython/scipystack
MAINTAINER Peter Romov <peter@romov.ru>

RUN apt-get install -y cmake libboost-all-dev wget

RUN git clone --depth=1 -b python-package https://github.com/romovpa/bigartm.git
WORKDIR bigartm

RUN mkdir build && cd build && cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr ..
RUN cd build && make -j
RUN cd build && make install

