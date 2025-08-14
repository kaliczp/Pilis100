library(lasR)
tempdir()
folder = "./"
pipeline = classify_with_sor() + delete_noise() + chm(0.5, ofile = "chm.tif") + dtm(0.5, ofile = "dtm.tif")
exec(pipeline, on = folder, ncores = concurrent_points(ncores = 5), progress = TRUE)
