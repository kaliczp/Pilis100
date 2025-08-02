cat("Start script\n")
library(lidR)
set_lidr_threads(3)
cat("Configured lidR threads: ")
get_lidr_threads()
lasname <- "Ground_points"
las <- readLAS(paste0(lasname, ".las"))
writeLAS(las, paste0(lasname, ".laz"))
cat("End script.\n")
