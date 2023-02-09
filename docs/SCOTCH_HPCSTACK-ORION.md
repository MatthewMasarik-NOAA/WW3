# SCOTCH Install using hpc-stack

## Orion
```
git clone https://gitlab.inria.fr/scotch/scotch.git
cd scotch
git checkout v7.0.3
mkdir build && cd build


mkdir -p ./modulefiles/gcc
cp -v /apps/modulefiles/core/gcc/10.2.0 ./modulefiles/gcc

# Edit file  ./modulefiles/gcc/10.2.0
#   Comment out line:  'family "compiler"'
#   Comment out line:  'prepend-path MODULEPATH /apps/modulefiles/compilers/gcc-10.2.0'

module purge
module use  ./modulefiles
module load gcc/10.2.0

module load cmake/3.22.1
module use  /work/noaa/epic-ps/hpc-stack/libs/intel/2022.1.2/modulefiles/stack
module load intel/2022.1.2
module load impi/2022.1.2
module load hpc/1.2.0
module load hpc-intel/2022.1.2
module load hpc-impi/2022.1.2

cmake -DCMAKE_Fortran_COMPILER=ifort            \
      -DCMAKE_C_COMPILER=icc                    \
      -DCMAKE_INSTALL_PREFIX=<path-to>/install  \
      -DCMAKE_BUILD_TYPE=Release ..             |& tee cmake.out
make  VERBOSE=1                                 |& tee make.out
make  install
```
