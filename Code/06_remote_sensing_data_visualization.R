# Code for managing and visualizing remote sensing data

install.packages("devtools")
library(devtools)

install_github("ducciorocchini/imageRy")
library(imageRy)

install.packages("ggplot2")
library(ggplot2)

# to get the list of all data inside imageRy
im.list()

# sentinel.dolomites.b2.tif data coming out of esa copernicus and Sentinel-2 is the name of the satellite
# b2 stands fro blue so working in 490nm, very short wavelenght, all objec treflecting blue is visible
# every function begins with im. for the package
# importing the data altought they are in R
b2 <-im.import("sentinel.dolomites.b2.tif" )

# use another colRampPalette
cl<- colorRampPalette(c("black", "grey", "lightgrey")) (100)
plot(b2,col=cl)

# refelctance 0<x<1 but here it's rescaled.

#b3 is bend for 560nm so import the image

# Exercise: import b3 green and plot with the previous palette
b3<- im.import("sentinel.dolomites.b3.tif")
plot(b3, col=cl)

# b2 and b3 are separated
# import b4 665nm for red band 
b4<- im.import("sentinel.dolomites.b4.tif") 
plot(b4, col=cl)

# b8 is near infrared (VNIR) is 840nm, not using b5,b6,b7 for the different resolution of 20 m instead of 10m
# import NIR band
b8<- im.import("sentinel.dolomites.b8.tif") 
plot(b8, col=cl)
# b8 since it's NIR is strictly related to vegetation. Why?

# per.function to make a Multiframe of images not talking to each other
par(mfrow=c(2,2))
plot(b2, col=cl)
plot(b3, col=cl)
plot(b4, col=cl)
plot(b8, col=cl)

# FIRST 3: mostly similar while Plot8 adds additional info
# stack them in a single image, layers overlapped in the same image made of 4 layers with data inside bu when i plot it each of the 4 images apper 
sentstack<- c(b2, b3, b4, b8)
plot(sentstack, col=cl)

# i want to plot only one layer of the data 
dev.off
plot(sentstack[[1]], col=cl) 
# or 
plot(sentstack[[4]], col=cl)

# multifrae with different col palette
# note taht if you plot only a band as b2, range blue-yellow readable for daltonics as well
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


# b8 has the higher discriminated resolution, many use this band
# bend and combine the colours together in RGB: red green and blue used by devices to get other colours
# we assign to each band a layer of the stack RGB

# RGB plotting with a function im.plotRGB to get a natural colour image
# sentsatck [[1]] blue
# sentsatck [[2]] green
# sentsatck [[3]] red
# sentsatck [[4]] NIR

im.plotRGB(sentstack, r=3, g=2, b=1) 

# RGB has 3 component but we have 4 bands
# facciamo scorrere i numeri we get false colours image so to add additional information that our eyes cannot perceive
im.plotRGB(sentstack, r=4, g=3, b=2) 

# why do that? vegetation is now represented by red 
