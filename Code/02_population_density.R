# how to calculate density of individuals in the population
# to import a packages install.packages.function
# let's use the function
install.packages("spatstat") # "" protects from exit R in and out of package
# to use the package library () without quotes because it's already in R now
# recalling the package
library(spatstat)

# use dataset bei in R it tells how many point in the databaseand soem info on window 
bei

# to get a plot a visual perception of dataset

plot(bei)

# let's change the graph w/ closed dots
plot(bei, pch=19)# remember to put space between argumets but avoid between brakes and function

plot(bei, pch=19, cex=.5)

# we can figure out how they are dispersed but not why

# additional dataset for covariates soil types, Temp., 
bei.extra # list of pixel images raster type

plot(bei.extra)

# let's look at elev elevation so we extract one of the two image or elements
# extracting data assigning an element to object elevation and linking elev to bei.extra using $ as a "rope" 
elevation <- bei.extra$elev

# then i plot only elev
plot(elevation)

# i just want the first element from bei.extra using [[]] and a number 1 without using $

elevation <- bei.extra[[1]]
# or if i have just an object 
plot(bei.extra[[1]])

# density is the function inside spatstat to calculate densuty of population
# density map starting from points
density(bei) # put desnity in an obj
densitymap <- density(bei)
densitymap #so every pixels has points inside
plot(densitymap)

# is there a possibility to show togheter the map of density and the original points
points(bei) # puts point on prevoius graph plot(densitymap)
points(bei, col="green")


