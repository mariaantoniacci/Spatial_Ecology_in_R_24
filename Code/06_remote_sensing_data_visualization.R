# Code for managing and visualizing remote sensing data

# we need devtools to import packages from Github
install.packages("devtools")
library(devtools)

# install_github("") is the function of devotools 
# user/package's name
install_github("ducciorocchini/imageRy")
library(imageRy)

# Alternative: to let other know where is the package from
devtools:: install_github("ducciorocchini/imageRy") 

install.packages("ggplot2")
library(ggplot2)

# to get the list of all data inside imageRy
im.list()

# sentinel.dolomites.b2.tif data coming out of esa copernicus and Sentinel-2 is the name of the satellite
# b2 stands for blue 
# so working in 490nm, very short wavelenght, all objects reflecting blue are visible
# every function begins with prefix im. for the package
# import the data altought they are in R
b2 <-im.import("sentinel.dolomites.b2.tif" )

# use another colRampPalette
cl<- colorRampPalette(c("black", "grey", "lightgrey")) (100)
plot(b2,col=cl)

# refelctance 0<x<1 but here it's rescaled

# b3 is band for 560nm so import the image

# Exercise: import b3 green and plot with the previous palette
b3<- im.import("sentinel.dolomites.b3.tif")
plot(b3, col=cl)

# b2 and b3 are separated
# import b4 665nm for red band 
b4<- im.import("sentinel.dolomites.b4.tif") 
plot(b4, col=cl)

# b8 is near infrared (VNIR) is 840nm
# we dont't use b5,b6,b7 for the different resolution of 20 m instead of 10m
# import NIR band
b8<- im.import("sentinel.dolomites.b8.tif") 
plot(b8, col=cl)
# since b8 is NIR it's strictly related to vegetation. Why?

# par() function to make a Multiframe of images not talking to each other
# first 3: mostly similar while Plotb8 adds additional info
par(mfrow=c(2,2))
plot(b2, col=cl)
plot(b3, col=cl)
plot(b4, col=cl)
plot(b8, col=cl)

# stack them in a single image, layers overlapped in the same image made of 4 layers with data inside
# when i plot sentstack each of the 4 images appears 
# now it's easier to manipulate it as a single object containing all info
# faster than par() to obtain multifrmae 2x2
sentstack<- c(b2, b3, b4, b8)
plot(sentstack, col=cl)

# i want to plot only one layer of the data with [[]] because it's a 2D image
dev.off()
plot(sentstack[[1]], col=cl) 
# or 
plot(sentstack[[4]], col=cl)

# multiframe with different colour palette
# note: if i plot only a band, as b2, range blue-yellow can be read by daltonics as well
par(mfrow=c(2,2))

clb<- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(b2, col=clb)

# Exercise: plot the same for the  band b3, b4, b8
clb<- colorRampPalette(c("dark green", "green", "light green")) (100)
plot(b3, col=clb)

clb<- colorRampPalette(c("dark red", "red", "pink")) (100)
plot(b4, col=clb)

clb<- colorRampPalette(c("brown", "orange", "yellow")) (100)
plot(b8, col=clb)

# remeber: 
# stacksent[[1]]= b2= blue
# stacksent[[2]]= b3= green
# stacksent[[3]]= b4= red
# stacksent[[4]]= b8= NIR
# b8 has the higher discriminated resolution, many use this band

# RGB plotting
# combine the colours together in RGB: red green and blue are filters used by devices to get new colours
# we assign to each band a layer or filter of the RGB
# use the function from imageRy im.plotRGB()
# inside () specify object and bands associated 
# in our case it's sentstack, then specify the filter to apply to each band

im.plotRGB(sentstack, r=3, g=2, b=1) 

# RGB has 3 component but we have 4 bands
# by switching numbers we get an image in false colours so to add additional information that our eyes cannot perceive
im.plotRGB(sentstack, r=4, g=3, b=2) 

# why putting NIR on red?
# everything that reflects NIR is visualized as red 
# vegetation reflects a lot in NIR
# that's why it's common to put NIR on top of red band of RGB

# let's try to put NIR on top of green band obtaining another false colour image
im.plotRGB(sentstack, r=3, g=4, b=2)

# or NIR on top of blue band
im.plotRGB(sentstack, r=3, g=2, b=4)















