library(lasR)
tempdir()
folder = "./"
pipeline = classify_with_sor() + delete_noise() + chm(1, ofile = "chm.tif") + dtm(1, ofile = "dtm.tif")
exec(pipeline, on = folder, ncores = concurrent_points(ncores = 5), progress = TRUE)
