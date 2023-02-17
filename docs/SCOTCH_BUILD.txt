# SCOTCH Installation
#
#  Dependencies:
#    - cmake
#    - Fortran90 compiler
#    - MPI
#    - GNU
#

git clone https://gitlab.inria.fr/scotch/scotch.git
cd scotch
git checkout v7.0.3
mkdir build && cd build

cmake -DCMAKE_Fortran_COMPILER=<F90-compiler>   \
      -DCMAKE_C_COMPILER=<C-compiler>           \
      -DCMAKE_INSTALL_PREFIX=<path-to-install>  \
      -DCMAKE_BUILD_TYPE=Release ..             |& tee cmake.out
make  VERBOSE=1                                 |& tee make.out
make  install
