# why populations disperse over the landscape in a certain manner?

# let's install two new packages "terra" and "sdm"
install.packages("sdm") # species distribution models
install.packages("terra")

library(sdm)
library(terra) 

# In R now I have a folder called sdm; inside the folder there’s another one called external. 

# how to make a subset of data, selecting some of those

sistem.file() # finds names of files in package for example the external folder

system.file("external") # """ because i'm extracting a folder 

# in external i have many dataset, i want one of them called species.shp

system.file("external/species.shp") 
# shp is an extension meaning shape file extension 
# /  means i want the  file called species in folder external 

# since external is used to be in all folders let's write which package we want the external from:

file <- system.file("external/species.shp", package="sdm")
[1] "C:/Users/anton/AppData/Local/R/win-library/4.4/sdm/external/species.shp"

# translate the shp file in a type of file R can use in vector
# the function is needed because shp cannot be read by R
vect(file) 

# in the meantime download library(terra)

# assign the function to an obj
rana <- vect(file)
rana 
# we obtain a series of info class spatvect, geometry (i could have points, vectors or polygones)
# in the file there's a table: for each point i have data occurance (1)/not occurance (0) for each species
# i know whether in point i, j, n, rana is present or not


# to see all data for rana for all points i type:

rana$Occurrence # maintain capital letter because R is capital sensitive

plot(rana) # points representing presence or absence of rana

# select only data containing 1 or presence of rana cutting out absence

# let's use sequel (sql) language on dataset rana -> used to select some data from a dataset which is rana 
# select all points from rana where occurrence equals 1 is translated in 

pres<- rana[rana$Occurrence==1 ;]

# in sql language == meaning equal to while != not equal to
# to end the input use ; 
# by writing rana before []: extract from the whole dataset rana 
# $ means: extract Occurance from rana where occurrence is equal to 1
# in R we'd use [[]] to extact data from a dataset

# build a multiframe: first image is rana, second image is pres 
par(mfrow=c(1,2))
plot(rana)
plot(pres)

# exercise: select data from rana with only absences
# uncertainity is higher for absences due to observer bias (non so se manca davvero, mentre so se c'è perchè l'ho visto)
abse<- rana[rana$Occurrence==0]
plot(abse) 

# exercise: plot in a multiframe presence beside absences 
par(mfrow=c(1,2))
plot(pres)
plot(abse)

# exercise the same but one above the other 
par(mfrow=c(2,1))
plot(pres)
plot(abse)

# exercise plot presences in blue together with absences in red 
plot(pres, col="blue") # open teh plot with presence and then 
points(abse, col="red", pch=19, cex=2) # use points to highlight absences

# Covariates, why species distributed in a certain manner?
# let's considerate the variable elevation 
# ascii related to raster sequential file in language .asc

elev <- system.file("external/elevation.asc", package="sdm") # it isn't a vector file in .shp but a raster file in .asc
# now i have the dataset elev which is raster so i use rast() to make it okay for R
elevmap <- rast(elev)

# change colours of the elevamap by the colorRampPalette function
cln<- colorRampPalette(c("purple4", "orange", "olivedrab2")) (100)
plot(elevmap, col=cln)

# exercise: plot the presence together with elevetion map
plot(elevmap, col=cln)
points(pres, pch=19) 
