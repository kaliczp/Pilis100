library(lidR)
library(sf)
Path <- "/home/kaliczp/mnt/disk/Munka/2022DINPIBörzsöny/Adatok/LiDAR_adat/Nyers_pontfelho_UTM34"

for(FileName in dir(Path)) {
    f <- paste(Path, FileName, sep = "/")
    las <- readLAS(f)
    bboxpoints <- st_bbox(las)
    bboxarea <- st_sf(data.frame(FileNr = substr(FileName, 11, 12),
                                 geom = st_as_sfc(bboxpoints)))
    if(FileName == "RAW_LiDAR_01.las") {
        bboxareaall <- bboxarea
    } else {
        bboxareaall <- rbind(bboxareaall, bboxarea)
    }
}
