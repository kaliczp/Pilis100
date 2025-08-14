#!/bin/bash
#SBATCH --job-name="laz save"
#SBATCH --time=00:02:00
#SBATCH --cpus-per-task=6
#SBATCH --mem-per-cpu=2000
#SBATCH --error=lasRtest.%J.stderr
#SBATCH --output=lasRtest.%J.stdout

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
TMPDIR=/project/p_erdlidar_scratch
export $TMPDIR
# Run script
cd /scratch/p_erdlidar/Pilis100
Rscript ./lasRtest.R
