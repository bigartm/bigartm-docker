FROM ipython/scipystack
MAINTAINER Peter Romov <peter@romov.ru>

RUN apt-get install -y cmake libboost-all-dev wget

RUN git clone --depth=1 https://github.com/bigartm/bigartm.git
WORKDIR bigartm

RUN mkdir build && cd build && cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr ..
RUN cd build && make -j && make install

RUN cp build/3rdparty/protobuf-cmake/protoc/protoc 3rdparty/protobuf/src/
RUN cd 3rdparty/protobuf/python && python setup.py build && python setup.py install 

RUN cd python && python setup.py install
