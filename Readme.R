## Read las
library(lidR)
las <- readLAS("Ground_points.laz")
plot(las)

install.packages('lasR', repos = 'https://r-lidar.r-universe.dev')
library(lasR)

install.packages('lidRviewer', repos = c('https://r-lidar.r-universe.dev'))
library(lidRviewer)
view(las)

## For mcc() RMCC
install.packages("RMCC")

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
## Poly mask creation
p100poly <- as.polygons(p100ers)
hullmask <- hull(p100poly, type="concave_ratio")

las <- readLAS("41.laz")
las <- classify_ground(las, algorithm = csf())
dtm_tin <- rasterize_terrain(las, res = 1, algorithm = tin())
library(terra)
aspect <- terrain(dtm_tin, "aspect", unit = "radians")
slope <- terrain(dtm_tin, "slope", unit = "radians")
hillshade <- shade(slope, aspect, 45, 304)
plot(hillshade)
## With grey
plot(hillshade,col = grey(c(0:100)/100), legend = F, maxcell = Inf)
writeRaster(dtm_tin,"dem.ers", filetype = "ERS")
plot_dtm3d(dtm_tin)

las1 <- clip_circle(las, 640260, 258590, 10)
trans1 <- clip_transect(las1, c(640260,258580), c(640260,258600), 1)

## Catalog
ActFile <- 41
ctg <- readLAScatalog(paste0(ActFile,".laz"), select = "xyzrn")
## Make spatial index
lidR:::catalog_laxindex(ctg)
opt_chunk_size(ctg) <- 90  # Define chunk size
opt_chunk_buffer(ctg) <- 30
opt_filter(ctg) <- "-drop_z_below 0"  # Exclude points with Z values below 0
opt_output_files(ctg) <- "./tile_{XLEFT}_{YBOTTOM}"  # Define output

## Watch together
p43 <- plot(las, size = 3, color = "RGB")
add_dtm3d(p43, dtm_tin)
