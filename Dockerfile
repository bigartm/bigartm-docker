FROM quay.io/pypa/manylinux1_x86_64
MAINTAINER Oleksandr Frei <oleksandr.frei@gmail.com>

RUN yum install -y bzip2-devel
RUN wget --no-check-certificate http://sourceforge.net/projects/boost/files/boost/1.60.0/boost_1_60_0.tar.gz && tar -xf boost_1_60_0.tar.gz && cd boost_1_60_0 && ./bootstrap.sh && ./b2 link=static,shared cxxflags="-std=c++11 -fPIC" --without-python && ./b2 install --without-python

# manylinux image came with pre-installed cmake 2.8.11.2, while protobuf-3 requires cmake 2.8.12.
# So, we have to manually install a newer version of cmake.
# Instructions taken from https://askubuntu.com/questions/355565/how-to-install-latest-cmake-version-in-linux-ubuntu-from-command-line.
RUN mkdir ~/temp && cd ~/temp && wget --no-check-certificate  https://cmake.org/files/v3.9/cmake-3.9.1.tar.gz && tar -xzvf cmake-3.9.1.tar.gz && cd cmake-3.9.1/ && ./bootstrap && make && make install && cd ~ && rm -rf ~/temp && cmake --version

RUN /opt/python/cp27-cp27mu/bin/pip install -U pip
RUN /opt/python/cp27-cp27mu/bin/pip install -U pytest pep8 wheel protobuf==3.0.0 numpy scipy pandas tqdm --only-binary numpy scipy pandas

#RUN git clone --branch v0.8.3 --depth=1 https://github.com/bigartm/bigartm.git
RUN git clone --branch pip --depth=1 https://github.com/ofrei/bigartm.git
WORKDIR bigartm

RUN mkdir build && cd build && cmake -DPYTHON=/opt/python/cp27-cp27mu/bin/python -DBUILD_TESTS=OFF -DBoost_USE_STATIC_LIBS=ON -DCMAKE_INSTALL_PREFIX:PATH=/usr .. && make && make install
