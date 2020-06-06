#!/bin/bash
NODES=`cat ~/NODES`
NP=`cat ~/NP`
#PBS -j oe
#PBS -l select=${NODES}:ncpus=1
CRADLE_VERSION=`cat ~/app/CRADLE_VERSION`

export PATH=$PATH:/opt/intel/impi/5.1.3.223/intel64/bin
export I_MPI_ROOT=/opt/intel/impi/5.1.3.223/bin64
I_MPI_ROOT=/opt/intel/impi/5.1.3.223/bin64
source /opt/intel/compilers_and_libraries/linux/mpi/bin64/mpivars.sh
source /opt/intel/bin/compilervars.sh intel64

export I_MPI_FABRICS=shm:dapl
export I_MPI_DAPL_PROVIDER=ofa-v2-ib0
export I_MPI_DYNAMIC_CONNECTION=0

#!/bin/bash
NODES=`cat ~/NODES`
NP=`cat ~/NP`

CRADLE_DIR="/shared/home/azureuser/apps/sct${CRADLE_VERSION}/bin"
source /shared/home/azureuser/apps/sct${CRADLE_VERSION}/Dsctsol${CRADLE_VERSION}/lib/lin/ii/mpi/bin/mpivars.sh
INPUT="~/tutorial.s"

${CRADLE_DIR}/sctsol13 -hpc ${INPUT} ${NP}:1 -genv I_MPI_DEBUG 5 | tee Cradle-`date +%Y%m%d_%H-%M-%S`.log
