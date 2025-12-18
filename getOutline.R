cat("Start script\n")
library(lidR)
set_lidr_threads(3)
cat("Configured lidR threads: ")
get_lidr_threads()
lazNameAll <- dir(patt="laz$")
for(lasname in lazNameAll){
    lasNum <- substr(lasname,11,12)
    las <- readLAS(paste0(lasname))
    density <- rasterize_density(las, res = 10)
    reclass <- c(0, Inf, 1)
    reclass_m <- matrix(reclass, ncol = 3, byrow = TRUE)
    densClass <- terra::classify(density, reclass_m)
    densClass[densClass == 0] <- NA
    lasVect <- as.polygons(densClass)
    lassf <- sf::st_as_sf(lasVect)
    lassf[,"ID"] <- paste0("O", lasNum)
}
cat("End script.\n")
