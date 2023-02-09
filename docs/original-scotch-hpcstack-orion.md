# SCOTCH Install using hpc-stack

## Orion
```
git clone https://gitlab.inria.fr/scotch/scotch.git
cd scotch
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
module load jasper/2.0.25
module load zlib/1.2.11
module load libpng/1.6.37
module load hdf5/1.10.6
module load netcdf/4.7.4
module load bacio/2.4.1
module load g2/3.4.5
module load w3emc/2.9.2
module load esmf/8.3.0b09

cmake -DCMAKE_Fortran_COMPILER=ifort            \
      -DCMAKE_C_COMPILER=icc                    \
      -DCMAKE_INSTALL_PREFIX=<path-to>/install  \
      -DCMAKE_BUILD_TYPE=Release ..             |& tee cmake.out
make  VERBOSE=1                                 |& tee make.out
make  install
```
