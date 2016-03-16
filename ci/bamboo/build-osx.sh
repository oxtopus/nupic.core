#!/bin/bash
set -o errexit
set -o xtrace

mkdir -p build/scripts
mkdir -p build/release/python2.7/site-packages
export PYTHONPATH=`pwd`/build/release/python2.7/site-packages:${PYTHONPATH}

# Cap'n Proto
curl -O https://capnproto.org/capnproto-c++-0.5.3.tar.gz
tar zxf capnproto-c++-0.5.3.tar.gz
pushd capnproto-c++-0.5.3
./configure --prefix=`pwd`/build/release
make install
popd

# nupic.core dependencies
pip install --upgrade --root=`pwd`/build/release setuptools
pip install --root=`pwd`/build/release -r bindings/py/requirements.txt pycapnp==0.5.5 wheel

# Build and install nupic.core
cmake . -DNTA_COV_ENABLED=ON -DCMAKE_INSTALL_PREFIX=`pwd`/build/release -DPY_EXTENSIONS_DIR=`pwd`/bindings/py/nupic/bindings
make install

# Build installable python packages
python setup.py bdist bdist_dumb bdist_wheel sdist
