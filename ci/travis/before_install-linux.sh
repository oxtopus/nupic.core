#!/bin/bash
# ----------------------------------------------------------------------
# Numenta Platform for Intelligent Computing (NuPIC)
# Copyright (C) 2013-5, Numenta, Inc.  Unless you have an agreement
# with Numenta, Inc., for a separate license for this software code, the
# following terms and conditions apply:
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero Public License version 3 as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU Affero Public License for more details.
#
# You should have received a copy of the GNU Affero Public License
# along with this program.  If not, see http://www.gnu.org/licenses.
#
# http://numenta.org/licenses/
# ----------------------------------------------------------------------
set -o verbose
set -o xtrace
set -o errexit
set -o pipefail

echo
echo Running before_install-linux.sh...
echo

# install gcc-4.8 for C++11 compatibility, #TODO remove when Travis has gcc>=4.8, (it's used for clang too, in coveralls)
alias gcc='gcc-4.8'
alias g++='g++-4.8'
if [ $CC == 'gcc' ]; then
    export CC='gcc-4.8'
    export CXX='g++-4.8'
fi

if [ $CC = 'clang' ]; then
    export CC='clang'
    export CXX='clang++'
fi

alias cc=${CC}
alias c++=${CXX}
printenv | sort

echo "Setting up python environment"
pip install virtualenv
virtualenv .
source bin/activate
pip install --upgrade setuptools
pip install --upgrade pip

echo "Installing Cap'n Proto..."
curl -O https://capnproto.org/capnproto-c++-0.5.2.tar.gz
tar zxf capnproto-c++-0.5.2.tar.gz
INSTALL_PREFIX=${PWD}
pushd capnproto-c++-0.5.2
./configure --prefix=${INSTALL_PREFIX}
make
make install
export LD_LIBRARY_PATH=${INSTALL_PREFIX}/lib:${LD_LIBRARY_PATH}
export LD_RUN_PATH=${INSTALL_PREFIX}/lib:${LD_RUN_PATH}
export CPPFLAGS="-I${INSTALL_PREFIX}/include"
export LDFLAGS="-L${INSTALL_PREFIX}/lib ${LDFLAGS}"
export PATH=${PATH}:${INSTALL_PREFIX}/include
popd

printenv | sort
ls -laFh lib
ls -laFh include

echo "Installing wheel..."
pip install wheel || exit
echo "Installing Python dependencies"
CC=${CC} CXX=${CXX} CFLAGS="-std=gnu++11 ${CFLAGS}" pip install -v pycapnp==0.5.7 --install-option="--force-system-libcapnp"

mkdir pycapnp
pushd pycapnp
git init pycapnp
git pull https://github.com/oxtopus/pycapnp.git gnu++11
git status
git log -n 1
CC=${CC} CXX=${CXX} CFLAGS="-std=gnu++11 ${CFLAGS}" pip install -v --install-option="--force-system-libcapnp" .
popd

pip install --use-wheel -r bindings/py/requirements.txt || exit

pip install cpp-coveralls


