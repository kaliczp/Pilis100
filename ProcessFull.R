library(lidR)
las <- readLAS("41.laz")
## Default csf
las <- classify_ground(las, algorithm = csf())
## Custom parameter csf
mycsf <- csf(sloop_smooth = TRUE, class_threshold = 0.4, cloth_resolution = 0.8, time_step = 0.9)
las <- classify_ground(las, mycsf)
gnd <- filter_ground(las)
