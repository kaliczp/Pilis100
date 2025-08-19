print("Start")
library(lidR)
set_lidr_threads(5L)
cat("Configured lidR threads: ")
get_lidr_threads()
ActFile <- "41"
## load packages
library(lidR)
library(future)
plan(multicore, workers = 5L)
## Read catalog
ctg <- readLAScatalog(paste0(ActFile,".laz"), select = "xyzrn")
## Make spatial index
lidR:::catalog_laxindex(ctg)
opt_chunk_size(ctg) <- 250  # Define chunk size
opt_chunk_buffer(ctg) <- 50
opt_filter(ctg) <- "-drop_z_below 0"  # Exclude points with Z values below 0
opt_output_files(ctg) <- "./gnd/tile_{XLEFT}_{YBOTTOM}"  # Define output
ctg1 <- classify_ground(ctg, algorithm = csf())
dtm_tin <- rasterize_terrain(ctg1, res = 1, algorithm = tin())
library(terra)
terra::crs(dtm_tin) <- "epsg:23700"
writeRaster(dtm_tin,paste0(ActFile,"dem.ers"), filetype = "ERS",overwrite=TRUE)
cat("End\n")
