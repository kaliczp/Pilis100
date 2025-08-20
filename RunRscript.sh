#!/bin/bash
#SBATCH --job-name="R script"
#SBATCH --time=00:20:00
#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=2000
#SBATCH --error=RScript.%J.stderr
#SBATCH --output=RScript.%J.stdout

# Set $PATH
PATH=/project/p_erdlidar/local/bin:$PATH
export PATH
LD_LIBRARY_PATH=/project/p_erdlidar/local/lib64:/project/p_erdlidar/local/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH
PKG_CONFIG_PATH=/project/p_erdlidar/local/lib64/pkgconfig:/project/p_erdlidar/local/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH
echo $PATH
# Run script
cd /scratch/p_erdlidar/
Rscript ./lazSaveCatalog.R
