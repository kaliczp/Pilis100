#!/bin/bash
#SBATCH --job-name="ERS R teszt job"
#SBATCH --time=3:00
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=2000
#SBATCH --output=ersRjob.out

module list
module swap PrgEnv-cray PrgEnv-gnu
module load cmake cray-python cray-parallel-netcdf cray-R
module list

# Set $PATH
PATH=/project/p_erdlidar/local/bin:$PATH
export PATH
LD_LIBRARY_PATH=/project/p_erdlidar/local/lib64:/project/p_erdlidar/local/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH
PKG_CONFIG_PATH=/project/p_erdlidar/local/lib64/pkgconfig:/project/p_erdlidar/local/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH

# Run script
cd /project/p_erdlidar/Pilis100
Rscript ./ERSscript.R
