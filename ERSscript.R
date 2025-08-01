library(lidR)
set_lidr_threads(3)
get_lidr_threads()
las <- readLAS("Ground_points.las")

## Read ERS
library(terra)
ers <- rast("DTM.ers")
plot(ers)
## Correct missing coordsystem
terra::crs(ers) <- "epsg:23700" # Csak terrával!

## DTM from las
pilis100dtm <- rasterize_canopy(las, res = 0.5)
terra::crs(pilis100dtm) <- "epsg:23700"

## Write ERS
writeRaster(pilis100dtm, "pilis100dtm.ers", filetype = "ERS", overwrite = TRUE)
rm(pilis100dtm) # free up memory
p100ers <- rast("pilis100dtm.ers")

## Filled raster
p100fill <- rasterize_canopy(las, res = 0.5, algorithm = p2r(subcircle = 0.2, na.fill = tin()))
terra::crs(p100fill) <- "epsg:23700"
p100mask <- focal(p100ers,w=3, mean, na.pol = "only", na.rm = TRUE)
writeRaster(p100mask, "focal.ers", filetype = "ERS")
p100fillm <- mask(p100fill, p100mask)
writeRaster(p100fillm, "TIN.ers", filetype = "ERS")
