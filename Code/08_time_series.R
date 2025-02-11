# From Sentinel data 
# Time series analysis in R

library(terra)
library(imageRy)

im.list()

# Importing data 
EN01 <- im.import("EN_01.png")

# it shows the amount of nitrogen in Europe, before the COVID lockdown, mainly related to Traffic pollution

EN13 <- im.import("EN_13.png")

# due to the stop of human activity lower nitrogen level 

# type EN01 to see info about it 
# let's take the first element of the dataset both for EN01 and EN13 and see the difference between January and March
difEN=EN01[[1]] - EN13[[1]]

# Importing all data all together changing dataset: Ice melting in Greenland 
# let's use a proxy for ice melting, non directly ice
# but its related parameter: soil temperature 

# "greenland" is part of the name of many files
gr <- im.import("greenland")

# 4 datasets, 4 elements
# to plot a single level, for example from 2005 which is the 2nd element in gr

plot(gr[[2]])

# multiframe: plot 1st and last elements of gr
par(mfrow=c(1,2))
plot(gr[[1]])
plot(gr[[4]])

# in 2015 very low temperatures only in the internal area, more ice melting 

difgr= gr[[1]]-gr[[4]]
plot(difgr)

# recall RGB: instead of band we put in the R G and B a different element, one yr per component

# exercise: RGB for 2000,2005,2015
im.plotRGB(gr, 1,2,3)

# variantions in frequencies given different classes, given datasets in time -> it's a ridgeline 
# for example: how many pixels (in RGB) corresponding to a x temp?


# takehome message:
# import all data all together, or two data and calculate the difference between the two. 
