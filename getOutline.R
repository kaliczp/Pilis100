cat("Start script\n")
library(lidR)
library(terra)
set_lidr_threads(3)
cat("Configured lidR threads: ")
get_lidr_threads()
lazNameAll <- dir(patt="laz$")
for(lazNameCurr in lazNameAll){
    lasNameOnly <- gsub(".laz", "", lazNameCurr)
    cat("Processed laz file: ", lasNameOnly, "\n")
    las <- readALS(lazNameCurr, select = "xyz")
    density <- rasterize_density(las, res = 10)
    reclass <- c(0, Inf, 1)
    reclass_m <- matrix(reclass, ncol = 3, byrow = TRUE)
    densClass <- terra::classify(density, reclass_m)
    densClass[densClass == 0] <- NA
    terra::crs(densClass) <- "epsg:23700"
    lasVect <- as.polygons(densClass)
    lassf <- sf::st_as_sf(lasVect)
    lassf[,"ID"] <- lasNameOnly
    if(lazNameCurr == lazNameAll[1]) {
        lazOutlines <- lassf["ID"]
    } else {
        lazOutlines <- rbind(lazOutlines,lassf["ID"])
    }
}
save(lazOutlines, file="Outlines.rda")
cat("End script.\n")
