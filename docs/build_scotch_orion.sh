#!/bin/bash

set -eux

BASEDIR="/work2/noaa/marine/mmasarik/projs/work_scotch"
BUILD_TYPE="Debug"
CTEST_RUN="NO"

name="scotch"
version=${VERSION:-"v7.0.3"}
INSTALL_PREFIX=${INSTALL_PREFIX:-${BASEDIR}/install/$name-$version}

#[[ -d ${BASEDIR}/$name-$version ]] && rm -rf ${BASEDIR}/$name-$version
[[ ! -d ${BASEDIR}/$name-$version ]] && git clone -b $version https://gitlab.inria.fr/scotch/scotch.git ${BASEDIR}/$name-$version
[[ ! -d ${BASEDIR}/$name-$version ]] && ( echo "${BASEDIR}/$name-$version does not exist, ABORT!"; exit 1)

set +x
module load cmake/3.22.1
module use  /work/noaa/epic-ps/hpc-stack/libs/intel/2022.1.2/modulefiles/stack
module load hpc/1.2.0
module load hpc-intel/2022.1.2
module load hpc-impi/2022.1.2
if [[ ${USE_GCC:-"YES"} = "YES" ]]; then
  # SCOTCH uses newer GCC headers that are not available unless this is loaded
  module use  ${BASEDIR}/modulefiles
  module load gcc/10.2.0
fi
module list
set -x

#GXX_ROOT=/apps/gcc-10.2.0/gcc-10.2.0
export CC=mpiicc     # icc makes no difference as hpc-impi is loaded
export FC=mpiifort   # ifort makes no difference as hpc-impi is loaded

[[ -d $INSTALL_PREFIX ]] && rm -rf $INSTALL_PREFIX

BUILD_DIR=${BUILD_DIR:-"build/$name-$version"}
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
