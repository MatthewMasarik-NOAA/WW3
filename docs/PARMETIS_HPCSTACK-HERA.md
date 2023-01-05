# Parmetis/Metis Install using hpc-stack

## Hera
```bash
PARMETIS_INSTALL=/scratch1/NCEPDEV/climate/Matthew.Masarik/waves/opt/hpc-stack/parmetis-4.0.3/install

# https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/parmetis/4.0.3-4/parmetis_4.0.3.orig.tar.gz  -- contains parmetis + metis.

tar xvfz parmetis_4.0.3.orig.tar.gz
cd parmetis-4.0.3

module purge
module load cmake/3.20.1
module load intel/2022.1.2
module load impi/2022.1.2
module use  /scratch1/NCEPDEV/nems/role.epic/hpc-stack/libs/intel-2022.1.2/modulefiles/stack
module load hpc/1.2.0
module load hpc-intel/2022.1.2
module load hpc-impi/2022.1.2
module load hdf5/1.10.6
module load netcdf/4.7.4
module load gnu/9.2.0
export CFLAGS=-fPIC


# Build: Metis
cd metis
make config cc=mpiicc                \
            cxx=mpiicc               \
            prefix=$PARMETIS_INSTALL |& tee metis-make-config.out
make VERBOSE=1                       |& tee metis-make.out
make install

# Build: ParMetis
cd ..
make config cc=mpiicc                \
            cxx=mpiicc               \
            prefix=$PARMETIS_INSTALL |& tee parmetis-make-config.out
make VERBOSE=1                       |& tee parmetis-make.out
make install



# Use: ParMetis
export METIS_PATH=$PARMETIS_INSTALL
```
