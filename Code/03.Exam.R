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
tc_ago1 <- rast("tc_ago1.tiff")
plot(tc_ago1)

#import for ago 2 in TC
b2_ago2 <- rast("b2_ago2.tiff") # blue
b3_ago2<- rast("b3_ago2.tiff") # green 
b4_ago2<- rast("b4_ago2.tiff") # red
stack_ago2<- c(b4_ago2, b3_ago2, b2_ago2) # create a stack
im.plotRGB(stack_ago2,1,2,3, title="28 August") # plot it in RGB 

# or alternatively and directly
tc_ago2 <- rast("tc_ago2.tiff")
plot(tc_ago2)

# to visualize them 
par(mfrow= c(1,2))
plot(tc_ago1)
title("8 August")
plot(tc_ago2)
title("28 August")

dev.off ()

# other bands needed is swir wherer
# 1= swir or b12
# 2 = nir or b8
# 3 = red
swir_ago1 <- rast("swir_ago1.tiff") 
swir_ago2 <- rast("swir_ago2.tiff") 

par(mfrow=c(1,2))
plot(swir_ago1)
title("8 August in SWIR")
plot(swir-ago2)
title("28 August in SWIR")

dev.off ()


# Ago 1 NBR
diff_ago1= swir_ago1[2] - swir_ago1[1]
sum_ago1= swir_ago1[2] + swir_ago1[1]
NBR_1=(diff_ago1)/(sum_ago1)

viridis <- colorRampPalette(viridis(7)) (255)
plot(NBR_1, col=viridis)

# Ago 2 NBR
diff_ago2= swir_ago2[2] - swir_ago2[1]
sum_ago2= swir_ago2[2] + swir_ago2[1]
NBR_2=(diff_ago2)/(sum_ago2)

viridis <- colorRampPalette(viridis(7)) (255)
plot(NBR_2, col=viridis)

stackNBR <- c(NBR_1,NBR_2)
names(stackNBR) <- c("8 August", "28 August")
plot(stackNBR, col=viridis)

# dNBR
dNBR= (NBR_1) - (NBR_2)
plot(dNBR, col=viridis, main="dNBR")
