library(lasR)
Path <- "/data"
FileName <- "RAW_LiDAR_01.las"
f <- paste(Path, FileName, sep = "/")
read <- reader()
tri <- triangulate(20, filter = keep_ground())
contour <- hulls(tri)
pipeline <- read + tri + contour
ans <- exec(pipeline, on = f)
plot(ans)
