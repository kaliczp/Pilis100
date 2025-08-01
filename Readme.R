## Read las
library(lidR)
las <- readLAS("Ground_points.las")
plot(las)

install.packages('lasR', repos = 'https://r-lidar.r-universe.dev')
library(lasR)

## Read ERS
library(terra)
ers <- rast("DTM.ers")
plot(ers)
## Correct missing coordsystem
terra::crs(ers) <- "epsg:23700" # Csak terrával!
plot_dtm3d(ers)

## DTM from las
pilis100dtm <- rasterize_canopy(las, res = 0.5)
terra::crs(pilis100dtm) <- "epsg:23700"
plot(pilis100dtm)
plot_dtm3d(pilis100dtm)

# Write ERS
writeRaster(pilis100dtm, "pilis100dtm.ers", filetype = "ERS", overwrite = TRUE)
rm(pilis100dtm) # free up memory
p100ers <- rast("pilis100dtm.ers")
