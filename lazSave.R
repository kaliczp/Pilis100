cat("Start script\n")
library(lidR)
set_lidr_threads(3)
cat("Configured lidR threads: ")
get_lidr_threads()
lasnameall <- dir(patt="las$")
for(lasname in lasnameall){
    las <- readLAS(paste0(lasname))
    lazname <- gsub(".las", ".laz", lasname)
    writeLAS(las, paste0(lazname))
}
cat("End script.\n")
