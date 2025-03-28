# YANOMAMI REGION AND GOLD MINING 
# two areas along the Uraricoera River in Roirama region in Brasil are studied
# comparisons are made before and after some years apart 
# these sites are known to be illegal as stated in https://mineria.amazoniasocioambiental.org/

# AREA A 
# 2016 vs 2023

setwd("C:/SPATIAL ECOLOGY IN R")
library(terra)
library(imageRy)

# 2016
B2_16<- rast("B2_2016_A.tiff") # blue
B3_16<- rast("B3_2016_A.tiff") # green 
B4_16<- rast("B4_2016_A.tiff") # red
stack16<- c(B4_16, B3_16, B2_16) # create a stack
im.plotRGB(stack16,1,2,3, title="2016") # plot it in RGB 

NIR_16<- rast("NIR_2016_A.tiff") # raster NIR to get false color image 
stack16FC<- c(NIR_16,B2_16,B3_16) # create a stack 

dvi_16= stack16FC[[1]] - stack16FC[[2]] # calculate dvi
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)
plot(dvi_16, col=cl) 
ndvi_16 = dvi_16 / (stack16FC[[1]] + stack16FC[[2]]) #and get the ndvi
plot(ndvi_16, col=cl) # plot the ndvi for vegetation 
im.classify(ndvi_16, num_clusters=3) # classification based in 3 clusters

class16<-im.classify(ndvi_16, num_clusters=3) # assign the classification to an object
f16 <- freq(class16) 
tot16 <- ncell(class16)
p16 = f16*100/tot16
p16 # get the % of the three clusters

# 2023
B2_23<- rast("B2_2023_A.tiff") # blue
B3_23<- rast("B3_2023_A.tiff") # green 
B4_23<- rast("B4_2023_A.tiff") # red
stack23<- c(B4_23, B3_23, B2_23) # create a stack
im.plotRGB(stack23,1,2,3, title="2023")
NIR_23<- rast("NIR_2023_A.tiff") # import NIR band 
stack23FC<- c(NIR_23,B4_23,B3_23) # stack for false colors image
im.plotRGB(stack23FC, 1,2,3,title = "2023") # False color image 

dvi_23= stack23FC[[1]] - stack23FC[[2]]
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)
plot(dvi_23, col=cl)
ndvi_23 = dvi_23 / (stack23FC[[1]] + stack23FC[[2]])
plot(ndvi_23, col=cl) # ndvi image 
im.classify(ndvi_23, num_clusters=3) # classification based on trhee clusters 

class23<-im.classify(ndvi_23, num_clusters=3) # assign to an object 
f23 <- freq(class23)
tot23 <- ncell(class23)
p23 = f23*100/tot23
p23 # % of three clusters

# to create a data frame
class <- c("Forest", "River Uraricoera", "Mining sites") 
Y16_A <- c(95.1, 4.1, 0.87 ) 
Y23_A<- c(92.2, 4.7, 3.1)
tabout <- data.frame(class, Y16_A, Y23_A) 
tabout

# !!! NOT SURE IT CAN WORK !!!
# when i classify the image from 2016 the clouds appearing in the image are classified as part of bare soil
# clouds and smaller sites in 2016 are classifed in the same cluster when num_cluster=3
# so i try to classify with num_clusters=2
# this way i have 
# 1. Forest 
# 2. River + Mining sites + Clouds
# while num_clusters=3 
# 1. Forest 
# 2. River
# 3. Mining sites 
# so from this
#              class Y16_A Y23_A
# 1           Forest 95.05  92.19
# 2 River Uraricoera  4.08   4.68
# 3     Mining sites  0.87   3.13

# to these trying to save a % from mining sites that actually belong to rivers we get these %s
#              class Y16_A Y23_A
# 1           Forest 95.05  92.19
# 2 River Uraricoera  4.68   4.68
# 3     Mining sites  0.27   3.13

# so get the plots of the site comparing 2016 and 2023
# True colors (B4,B3,B2)
par(mfrow=c(1,2))
im.plotRGB(stack16,1,2,3, title="2016")
im.plotRGB(stack23,1,2,3, title="2023")

# False Colors (NIR,B4,B3)
par(mfrow=c(1,2))
im.plotRGB(stack16FC, 1,2,3,title = "2016")
im.plotRGB(stack23FC, 1,2,3,title = "2023")

# NDVI 
par(mfrow=c(1,2))
plot(ndvi_16, col=cl, main="2016")
plot(ndvi_23, col=cl, main="2023")

# Classifications 
par(mfrow=c(1,2))
im.classify(ndvi_16, num_clusters=3)
im.classify(ndvi_23, num_clusters=3) 
