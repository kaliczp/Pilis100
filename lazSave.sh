#!/bin/bash
#SBATCH --job-name="laz save"
#SBATCH --time=00:02:00
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=2000
#SBATCH --error=ersR.%J.stderr
#SBATCH --output=ersR.%J.stdout

module list
module load cmake cray-python cray-parallel-netcdf
module list

# Set $PATH
PATH=/project/p_erdlidar/local/bin:$PATH
export PATH
LD_LIBRARY_PATH=/project/p_erdlidar/local/lib64:/project/p_erdlidar/local/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH
PKG_CONFIG_PATH=/project/p_erdlidar/local/lib64/pkgconfig:/project/p_erdlidar/local/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH
echo $PATH

# Run script
cd /project/p_erdlidar/Pilis100
Rscript ./lazSave.R
