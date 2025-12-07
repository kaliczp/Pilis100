library(lasR)
library(lidR)
Path <- "/home/kaliczp/mnt/disk/Munka/2022DINPIBörzsöny/Adatok/LiDAR_adat/Nyers_pontfelho_UTM34"
FileName <- "RAW_LiDAR_01.las"
f <- paste(Path, FileName, sep = "/")
las <- readLAS(f)
bboxpoints <- st_bbox(las)
bboxarea <- st_as_sfc(area)
