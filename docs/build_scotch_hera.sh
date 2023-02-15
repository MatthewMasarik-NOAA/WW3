#!/bin/bash

set -eux

BASEDIR="/scratch1/NCEPDEV/climate/Matthew.Masarik/waves/opt/hpc-stack"
##BUILD_TYPE="Debug"
BUILD_TYPE="Release"
CTEST_RUN="NO"

name="scotch"
version=${VERSION:-"v7.0.3"}
INSTALL_PREFIX=${INSTALL_PREFIX:-${BASEDIR}/$name-$version/install}

tar xvf

#[[ -d ${BASEDIR}/$name-$version ]] && rm -rf ${BASEDIR}/$name-$version
#[[ ! -d ${BASEDIR}/$name-$version ]] && git clone -b $version https://gitlab.inria.fr/scotch/scotch.git ${BASEDIR}/$name-$version
[[ ! -d ${BASEDIR}/$name-$version ]] && ( echo "${BASEDIR}/$name-$version does not exist, ABORT!"; exit 1)

set +x
module purge
module load cmake/3.20.1
module load intel/2022.1.2
module load impi/2022.1.2
module use  /scratch1/NCEPDEV/nems/role.epic/hpc-stack/libs/intel-2022.1.2/modulefiles/stack
module load hpc/1.2.0
module load hpc-intel/2022.1.2
module load hpc-impi/2022.1.2
module load gnu/9.2.0
module list
set -x

export CC=mpiicc     # icc makes no difference as hpc-impi is loaded
export FC=mpiifort   # ifort makes no difference as hpc-impi is loaded

[[ -d $INSTALL_PREFIX ]] && rm -rf $INSTALL_PREFIX

BUILD_DIR=${BUILD_DIR:-"$name-$version/build"}
[[ ${BUILD_CLEAN:-"YES"} = "YES" ]] && rm -rf ${BUILD_DIR}
mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}

cmake ${BASEDIR}/$name-$version \
      ${CMAKE_OPTIONS:-} \
      -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX} \
      -DCMAKE_BUILD_TYPE=${BUILD_TYPE:-"Release"} \
      -DTHREADS=OFF
make -j ${BUILD_JOBS:-1} VERBOSE=${BUILD_VERBOSE:-}
[[ ${CTEST_RUN:-"NO"} = "YES" ]] && ctest -j ${CTEST_JOBS:-1}
make install
