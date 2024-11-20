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

# Exercise: import b3 and plot with the previous palette
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








