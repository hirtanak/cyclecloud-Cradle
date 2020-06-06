#!/bin/bash
#PBS -j oe
#PBS -l nodes=2:ppn=15

CRADLE_DIR="/shared/home/azureuser/apps/sct/bin"
MPI_ROOT="/shared/home/azureuser/apps/sct/platform_mpi/bin"
INPUT="/shared/home/azureuser/apps/sct/Dsct13MP_test-hirost01/tutrial.s"

cd ${PBS_O_WORKDIR}
NP=$(wc -l ${PBS_NODEFILE} | awk '{print $1}')
${CRADLE_DIR}/sctsol13 -hpc ${INPUT} -np ${NP} | tee Cradle-`date +%Y%m%d_%H-%M-%S`.log
