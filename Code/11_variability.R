# measuring spatial variability 


# the higher the complexity, the higher the potential biodiversity 
# rasterdiv() function to measure variability 
# st. dev. of reflectance values helps in measuring variability over an image, complexity of a landscape

library(imageRy)
library(terra)
im.list()

# use data from Sentinel satelite
sent <- im.import("sentinel.png")

# plot it without changing the order of the bands
im.plotRGB(sent, r=1, g=2, b=3)

# bands:
# 1 = NIR
# 2 = red 
# 3 = green 

# now try to change order to get even more details in yellow for example
im.plotRGB(sent, 2,3,1) 

# measure standard deviation on a chosen band

# obj sent is made of 4 elements, let's choose only the first 
# let's associate the band to an object
nir <- sent[[1]]

# calculate st. dev. with the function focal()

stdev3 <- focal(nir, matrix(1/9, 3,3), fun=sd)

# focal() uses a moving window as a method to measure st. dev.
# specify:
# image with chosen band ([[1]])
# a matrix (2 dimensional vector) to create the moving window
# matrix (taht is the moving window) is made of 3x3 pixels (3 rows and 3 columns)
# argoment 1/9 to specify that i want to use 1 pixel (data) over the total 9 pixels
# fun= to specify i want to calculate the standard deviation (sd)

# exercise: matrix of 7x7 
stdev7 <- focal(nir, matrix(1/49, 7,7), fun=sd)
# the bigger the window the bigger the standard deviation
# it's because we're taking a bigger area 

# multiframe to show difference between the variabilities calculated with two differently built windows
par(mfrow=c(1,2))
plot(stdev3)
plot(stdev7)

# alternative using stack to plot two images together
stdevstack <- c(stdev3, stdev7) 
plot(stdevstack)  

# notes:
# bigger windows mean lower resolution
# how to choose dimension of the matrix?
# there's no right or wrong, try with different windows and choose the best 


