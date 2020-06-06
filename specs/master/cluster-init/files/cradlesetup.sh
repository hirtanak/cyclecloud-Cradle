#!/bin/sh

export PATH=$PATH:/opt/intel/impi/5.1.3.223/intel64/bin
export I_MPI_ROOT=/opt/intel/impi/5.1.3.223/bin64
I_MPI_ROOT=/opt/intel/impi/5.1.3.223/bin64
source /opt/intel/compilers_and_libraries/linux/mpi/bin64/mpivars.sh
source /opt/intel/bin/compilervars.sh intel64

export I_MPI_FABRICS=shm:dapl
export I_MPI_DAPL_PROVIDER=ofa-v2-ib0
export I_MPI_DYNAMIC_CONNECTION=0
