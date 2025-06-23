# GREECE WILDFIRES 2023 
# AIM 1: PRE AND POST FIRES with NBR
# AIM 2: VEGETATION HEALTH with NDVI

setwd("C:/SPATIAL ECOLOGY IN R")
library(terra)
library(imageRy)
library(viridis)
library(ggplot2)
library(patchwork)



# ago 1 vs ago 2
# import bands for ago 1 in TC
b2_ago1 <- rast("b2_ago1.tiff") # blue
b3_ago1<- rast("b3_ago1.tiff") # green 
b4_ago1<- rast("b4_ago1.tiff") # red
stack_ago1<- c(b4_ago1, b3_ago1, b2_ago1) # create a stack
im.plotRGB(stack_ago1,1,2,3, title="8 August") # plot it in RGB 

# or alternatively and directly
tc_1 <- rast("tc1_jpg.jpg")
plot(flip(tc_1))

#import for ago 2 in TC
b2_ago2 <- rast("b2_ago2.tiff") # blue
b3_ago2<- rast("b3_ago2.tiff") # green 
b4_ago2<- rast("b4_ago2.tiff") # red
stack_ago2<- c(b4_ago2, b3_ago2, b2_ago2) # create a stack
im.plotRGB(stack_ago2,1,2,3, title="28 August") # plot it in RGB 

# to visualize them 
par(mfrow= c(1,2))
im.plotRGB(stack_ago1,1,2,3, title="8 August") # plot it in RGB 
im.plotRGB(stack_ago2,1,2,3, title="28 August") # plot it in RGB


dev.off ()

# other bands needed is swir wherer
# 1= swir or b12
# 2 = nir or b8
# 3 = red

# or using bands from copernicus ago 1
b12_ago1 <- rast("b12_ago1.tiff") # swir
nir_ago1<- rast("nir_ago1.tiff") # nir 
b4_ago1<- rast("b4_ago1.tiff") # red
stack_swir1<- c(b12_ago1, nir_ago1, b4_ago1) # create a stack
im.plotRGB(stack_swir1,1,2,3, title="8 August") # plot it in RGB 

# ago 2
b12_ago2 <- rast("b12_ago2.tiff") # swir
nir_ago2<- rast("nir_ago2.tiff") # nir 
b4_ago2<- rast("b4_ago2.tiff") # red
stack_swir2<- c(b12_ago2, nir_ago2, b4_ago2) # create a stack
im.plotRGB(stack_swir2,1,2,3, title="28 August") # plot it in RGB 

#together
par(mfrow=c(1,2))
im.plotRGB(stack_swir1,1,2,3, title="8 August in SWIR") # plot it in RGB 
im.plotRGB(stack_swir2,1,2,3, title="28 August in SWIR") 

dev.off ()

# or without using .tiff but .jpg
swir1<- rast("swir1_jpg.jpg")
swir2<- rast("swir2_jpg.jpg")
plot(flip(swir1))
plot(flip(swir2))

# to visualise
par(mfrow=c(1,2))
plot(flip(swir1), main="8 August in SWIR")
plot(flip(swir2), main="28 August in SWIR")

# Ago 1 NBR
diff_1= swir1[[2]] - swir1[[1]]
sum_1= swir1[[2]] + swir1[[1]]
NBR_1=(diff_1)/(sum_1)

viridis <- colorRampPalette(viridis(7)) (255)
plot(flip(NBR_1), col=viridis)

# Ago 2 NBR
diff_2= swir2[[2]] - swir2[[1]]
sum_2= swir2[[2]] + swir2[[1]]
NBR_2=(diff_2)/(sum_2)

viridis <- colorRampPalette(viridis(7)) (255)
plot(flip(NBR_2), col=viridis)

stackNBR <- c(NBR_1,NBR_2)
names(stackNBR) <- c("8 August", "28 August")
plot(flip(stackNBR), col=viridis)

# dNBR
dNBR= (NBR_1) - (NBR_2)
plot(flip(dNBR), col=viridis, main="dNBR")

classdnbr<- im.classify(dNBR, num_clusters= 3)
class.names<- c("Heavily damaged area", "Moderately damaged area", "No damage") #chack che ordine sia giusto 
plot(flip(classdnbr), main="Effects of the wildfire", type="classes", levels=class.names, col="red","orange","white")

classdnbr<- im.classify(dNBR, num_clusters=2)
class.names<- c("Burnt vegetation", "No damage/Healthy vegetation") #chack che ordine sia giusto 
plot(flip(classdnbr), main="Effects of the wildfire", type="classes", levels=class.names, col=c("red","green"))

freq<- freq(classdnbr)
tot<- ncell(classdnbr)
prop= freq/tot
perc=prop*100
perc


