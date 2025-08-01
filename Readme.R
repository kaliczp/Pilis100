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
crs(ers) <- "epsg:23700"
plot_dtm3d(ers)
