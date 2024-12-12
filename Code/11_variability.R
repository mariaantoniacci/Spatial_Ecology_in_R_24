# the higher the complexity, the higher the potential biodiversity 
# rasterdiv() function to measure variability 
# st. dev. measure over an image

library(imageRy)
library(terra)
library(viridis)

# use data from Sentinel satelite

im.list()
sent <- im.import("sentinel.png")
im.plotRGB(sent, r=1, g=2, b=3)

# bands:
# 1 NIR
# 2 red 
# 3 green 

# yellow hits the retina differntly, good to use 
im.plotRGB(sent, 2,3,1) 

# measuring standard deviation focal() to use variability
nir <- sent[[1]]
stdev3 <- focal(nir, matrix(1/9, 3,3), fun=sd)

# moving window is a method to measure st. dev.
# window of 3x3 pixels 3 rows 3 cols, we extract the mean and then extract st. dev. from here
# moving by one, again calculate mean on a window 3x3
# matrix is the moving winddw
# single data are single pixels so each pixel is 1 over 9 pixel
# stdev helps us calculating variability, cause it's difficult to measure it on the image trhought colours. 


# exercise 7x7 
stdev7 <- focal(nir, matrix(1/49, 7,7), fun=sd)

par(mfrow=c(1,2))
plot(stdev3)
plot(stdev7)

# is like taking more data alltogether the wider the sample, the higher the st dev respect to original mean.
# wider in terms of higher st dev 
# no best windows it dependes on the issue 
# in the first picture less variability just beacuse the window is smaller 










