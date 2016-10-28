FROM ipython/scipystack
MAINTAINER Oleksandr Frei <oleksandr.frei@gmail.com>

RUN apt-get update -y
RUN apt-get install -y cmake libboost-all-dev wget

RUN git clone --depth=1 https://github.com/bigartm/bigartm.git
WORKDIR bigartm

RUN mkdir build && cd build && cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr ..
RUN cd build && make -j && make install

RUN cd 3rdparty/protobuf-3.0.0/python && python setup.py build && python setup.py install
RUN cd 3rdparty/protobuf-3.0.0/python && python3 setup.py build && python3 setup.py install
RUN cd python && python setup.py install
RUN cd python && python3 setup.py install

ENV ARTM_SHARED_LIBRARY=/tmp/bigartm/build/src/artm/libartm.so
