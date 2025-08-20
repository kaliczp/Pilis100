cat("Start script\n")
nothreads <- 10L
library(lidR)
library(future)
plan(multicore, workers = nothreads)
set_lidr_threads(nothreads)
cat("Configured lidR threads: ")
get_lidr_threads()
ctg <- readLAScatalog("vgyok/")
st_crs(ctg) <- 23700
opt_chunk_buffer(ctg) <- 0
opt_chunk_size(ctg) <- 0
opt_laz_compression(ctg) <- TRUE
opt_filter(ctg) <- "-drop_z_below 1"
opt_output_files(ctg) <- "vgylaz/{ORIGINALFILENAME}"
newctg = catalog_retile(ctg)
cat("End script.\n")
