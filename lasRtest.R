library(lasR)
folder = "./"
pipeline = classify_with_sor() + delete_noise() + chm(1) + dtm(1)
exec(pipeline, on = folder, ncores = concurrent_points(ncores = 5), progress = TRUE)
