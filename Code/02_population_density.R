# how to calculate density of individuals in the population
# to import a packages install.packages is the function to use
# let's use the function
install.packages("spatstat") # "" protects from exit R in and out of package
# to use the package library () without quotes because it's already in R now
# recalling the package
library(spatstat)

# use dataset bei in R: it tells how many points in the database and some info on window 
bei

# to get a plot a visual perception of dataset

plot(bei)

# let's change the graph w/ closed dots
plot(bei, pch=19) # remember to put space between argumets but avoid between brakes and function

plot(bei, pch=19, cex=.5)

# we can figure out how they are dispersed but not why they are so

# additional dataset for covariates soil types, temperature, etc. 
bei.extra # list of pixel images raster type

plot(bei.extra)

# let's look at elev (elevation) so we extract one of the two image which are elements
# extracting data assigning an element to object elevation and linking elev to bei.extra using $ as a "rope" 
elevation <- bei.extra$elev

# then i plot only elev
plot(elevation)

# i just want the first element from bei.extra using [[]] and a number 1 without using $

elevation2 <- bei.extra[[1]]

# or if i have just an object 

plot(bei.extra[[1]]) # [[]] more powerful because i dont'have to remember the name of the element i need
plot(elevation2)


# density is the function inside spatstat to calculate density of population
# let's build a density map starting from points
density(bei) 
# put density in an obj
densitymap <- density(bei)
densitymap # so every pixel has points inside
plot(densitymap)

# Is there a possibility to show togheter the map of density and the original points?
points(bei) # puts points on prevoius graph plot (densitymap)
points(bei, col="green")

######DAY2
# multiframe with par.function

par(mfrow=c(1,2)) # 1 and 2 are elements of the same arrow 

#now put sets in the elements

plot(elevation2)
plot(densitymap)
# the order is set like this sx elev2 a dx density
# if i want one above the other i'd have 2 rows and 1 coloumn
 par(mfrow=c(2,1))

#if i want again just one map at the centre of the screen and not above or at a side
# i use dev.off() control multiple devides. destroys the device null device

dev.off()

#changing colours to map
cl <- colorRampPalette(c("red", "orange", "yellow")) (3)
# watch out capital letters 
# elements of the same arrow so use c()
# stating (3) is for gradients but the gradients are written like taht in brakets
# assign it to an obj
plot(densitymap, col=cl)

# let's increase the amount of gradients 
cl <- colorRampPalette(c("red", "orange", "yellow")) (100)

# exercise: change teh color ramp palette using different colors 
# search colors in R Columbia university for gradients

# exercise: build a multiframe and plot the densitymapwith two different color ramp palette
par(mfrow=c(1,2))
cl <- colorRampPalette(c("palegreen", "purple3", "orange3")) (100)
plot(densitymap, col=cl)
cl <- colorRampPalette(c("olivedrab2", "orange1", "red3")) (100)
plot(densitymap, col=cl)

# dev.off() to kill everything
