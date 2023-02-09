#!/bin/bash --login

# https://gitlab.inria.fr/scotch/scotch.git

BLD_TYPE=Debug
##BLD_TYPE=Release
SCOTCH_GZ=scotch.v7.0.3.tar.gz

tar xvf $SCOTCH_GZ
cd scotch
git checkout v7.0.3

module purge
module load cmake/3.20.1
module load gnu/9.2.0
module load intel/2022.1.2
module load impi/2022.1.2
module use  /scratch1/NCEPDEV/nems/role.epic/hpc-stack/libs/intel-2022.1.2/modulefiles/stack
module load hpc/1.2.0
module load hpc-intel/2022.1.2
module load hpc-impi/2022.1.2

mkdir build && cd build
cmake -DCMAKE_Fortran_COMPILER=ifort            \
      -DCMAKE_C_COMPILER=icc                    \
      -DCMAKE_INSTALL_PREFIX=install            \
      -DCMAKE_BUILD_TYPE=$BLD_TYPE ..           |& tee cmake.out
make  VERBOSE=1                                 |& tee  make.out
make  install
