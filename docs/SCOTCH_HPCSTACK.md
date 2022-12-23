# SCOTCH Install using hpc-stack

## Hera
```
# download outside hera
git clone https://gitlab.inria.fr/scotch/scotch.git

# transfer scotch to hera

cd scotch

module purge
module load cmake/3.20.1
module load intel/2022.1.2
module load impi/2022.1.2
module use  /scratch1/NCEPDEV/nems/role.epic/hpc-stack/libs/intel-2022.1.2/modulefiles/stack
module load hpc/1.2.0
module load hpc-intel/2022.1.2
module load hpc-impi/2022.1.2
module load netcdf/4.7.4
module load gnu

mkdir build && cd build
cmake -DCMAKE_Fortran_COMPILER=ifort            \
      -DCMAKE_C_COMPILER=icc                    \
      -DCMAKE_INSTALL_PREFIX=<path-to>/install  \
      -DCMAKE_BUILD_TYPE=Release ..             |& tee cmake.out
make  VERBOSE=1                                 |& tee make.out
make  install
```
