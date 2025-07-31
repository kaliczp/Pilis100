## Read las
library(lidR)
las <- readLAS("Ground_points.las")
plot(las)

## Read ERS
library(terra)
ers <- rast("DTM.ers")
plot(ers)
