#!/bin/bash
# Copyright (c) 2020 Hiroshi Tanaka, hirtanak@gmail.com @hirtanak
set -exuv

echo "starting 10.execute.sh"

# disabling selinux
echo "disabling selinux"
setenforce 0
sed -i -e "s/^SELINUX=enforcing$/SELINUX=disabled/g" /etc/selinux/config

CUSER=$(grep "Added user" /opt/cycle/jetpack/logs/jetpackd.log | awk '{print $6}')
CUSER=${CUSER//\'/}
CUSER=${CUSER//\`/}
# After CycleCloud 7.9 and later 
if [[ -z $CUSER ]]; then
   CUSER=$(grep "Added user" /opt/cycle/jetpack/logs/initialize.log | awk '{print $6}' | head -1)
   CUSER=${CUSER//\`/}
fi
echo ${CUSER} > /mnt/exports/shared/CUSER
HOMEDIR=/shared/home/${CUSER}
CYCLECLOUD_SPEC_PATH=/mnt/cluster-init/Cradle/execute

cFLOW_VERSION=13
scFLOW_VERSION=$(jetpack config scFLOW_VERSION)
STREAM_VERSION=st2020
STREAM_VERSION=$(jetpack config STREAM_VERSION)

# resource ulimit setting
CMD1=$(grep memlock /etc/security/limits.conf | head -2)
if [[ -z "${CMD1}" ]]; then
  (echo "* hard memlock unlimited"; echo "* soft memlock unlimited"; echo "* hard nofile 65535"; echo "* soft nofile 65535") >> /etc/security/limits.conf
fi

## Checking VM SKU and Cores
VMSKU=`cat /proc/cpuinfo | grep "model name" | head -1 | awk '{print $7}'`
CORES=$(grep cpu.cores /proc/cpuinfo | wc -l)

# mandatory packages
yum install -y redhat-lsb-core htop

## H16r or H16r_Promo
if [[ ${CORES} = 16 ]] ; then
  echo "Proccesing H16r"
  grep "vm.zone_reclaim_mode = 1" /etc/sysctl.conf || echo "vm.zone_reclaim_mode = 1" >> /etc/sysctl.conf sysctl -p
fi

## HC/HB set up
if [[ ${CORES} = 44 ]] ; then
  echo "Proccesing HC44rs"
  grep "vm.zone_reclaim_mode = 1" /etc/sysctl.conf || echo "vm.zone_reclaim_mode = 1" >> /etc/sysctl.conf sysctl -p
fi

if [[ ${CORES} = 60 ]] ; then
  echo "Proccesing HB60rs"
  grep "vm.zone_reclaim_mode = 1" /etc/sysctl.conf || echo "vm.zone_reclaim_mode = 1" >> /etc/sysctl.conf sysctl -p
fi

if [[ ${CORES} = 120 ]] ; then
  echo "Proccesing HB120rs_v2"
  grep "vm.zone_reclaim_mode = 1" /etc/sysctl.conf || echo "vm.zone_reclaim_mode = 1" >> /etc/sysctl.conf sysctl -p
fi

# Installation
case ${scFLOW_VERSION} in
    11, 13 )
    # scFLOW Directory
    if [[ ! -d /opt/intel/impi/5.1.3.223 ]]; then
       tar zxf ${HOMEDIR}/apps/l_mpi_p_5.1.3.223.tgz -C ${HOMEDIR}/apps/
       sed -i -e 's/ACCEPT_EULA=decline/ACCEPT_EULA=accept/' ${HOMEDIR}/apps/l_mpi_p_5.1.3.223/silent.cfg
       sed -i -e 's/ACTIVATION_TYPE=exist_lic/ACTIVATION_TYPE=trial_lic/' ${HOMEDIR}/apps/l_mpi_p_5.1.3.223/silent.cfg
       ${HOMEDIR}/apps/l_mpi_p_5.1.3.223/install.sh -s ${HOMEDIR}/apps/l_mpi_p_5.1.3.223/silent.cfg
    fi
    ;;
esac

echo "end of 10.execute.sh"
