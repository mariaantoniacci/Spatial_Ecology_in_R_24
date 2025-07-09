# SPATIAL ECOLOGY IN R EXAM -  Student: MARIA ANTONIACCI (SGN)
# WILDFIRES in GREECE - August 2023 
# In August 2023, a massive wildfire broke out in the Evros region of northeastern Greece,
# spreading rapidly from the mountainous areas to the city of Alexandroupolis.
# Approximately 80,000 hectares of land were burned, including the forest within the Dadia–Lefkimi–Soufli Forest National Park.
# This event is considered to be the largest wildfire ever recorded in Europe since the year 2000.

# The project has two objectives, addressed through two analyses:
# 1: Assessing Pre and Post Wildfire Conditions using NBR
# 2: Evaluating Vegetation Recovery Trends over the years in June using NDVI

# First, set the working directory and recall libraries 
setwd("C:/SPATIAL ECOLOGY IN R")
library(terra) # For spatial analyses
library(imageRy) # To manipulate raster images in R
library(viridis) # For colour palettes suitable for color blind people
library(ggplot2) # To create graphics
library(patchwork) # For coupling graphics

## 1: Assessing Pre and Post Wildfire Conditions using the Normalized Burn Ratio (NBR)  

# Data are obtained from Copernicus Browser, Sentinel-2

# Loading bands to compose an image in True Colors for Pre-wildfire
# 8 August
b2_ago1 <- rast("b2_ago1.tiff") # Blue
b3_ago1<- rast("b3_ago1.tiff") # Green 
b4_ago1<- rast("b4_ago1.tiff") # Red
stack_ago1<- c(b4_ago1, b3_ago1, b2_ago1) # create a stack

# Loading bands to compose an image in True Colors for Post-wildfire
# 28 August
b2_ago2 <- rast("b2_ago2.tiff") # Blue
b3_ago2<- rast("b3_ago2.tiff") # Green 
b4_ago2<- rast("b4_ago2.tiff") # Red
stack_ago2<- c(b4_ago2, b3_ago2, b2_ago2) # create a stack

# Multiframe using par(mfrow=): layout is  1-row and 2-colums
par(mfrow= c(1,2))
im.plotRGB(stack_ago1,1,2,3, title="8 August") # plot it in RGB 
im.plotRGB(stack_ago2,1,2,3, title="28 August") # plot it in RGB

dev.off ()

# In general, to analyse images after wildfire NBR index is used
# NBR (Normalized Burn Ratio) is a normalized index that uses SWIR and NIR bands
# SWIR (Short-Wave InfraRed) shows high reflectance on burned vegetation and low reflectance of healthy vegetation.

# Import bands to get images so composed:
# 1st band = SWIR or B12
# 2nd band = NIR or B8
# 3rd band = Red or B4

# 8 August
b12_ago1 <- rast("b12_ago1.tiff") # SWIR
nir_ago1<- rast("nir_ago1.tiff") # NIR
b4_ago1<- rast("b4_ago1.tiff") # Red
stack_swir1<- c(b12_ago1, nir_ago1, b4_ago1) # create a stack

# 28 August
b12_ago2 <- rast("b12_ago2.tiff") # SWIR
nir_ago2<- rast("nir_ago2.tiff") # NIR 
b4_ago2<- rast("b4_ago2.tiff") # Red
stack_swir2<- c(b12_ago2, nir_ago2, b4_ago2) # create a stack

# Multiframe
par(mfrow=c(1,2))
im.plotRGB(stack_swir1,1,2,3, title="8 August in SWIR") 
im.plotRGB(stack_swir2,1,2,3, title="28 August in SWIR") 

dev.off ()

# Get NBR for 8 August
diff_1= stack_swir1[[2]] - stack_swir1[[1]] # NIR - SWIR
sum_1= stack_swir1[[2]] + stack_swir1[[1]] # NIR + SWIR
NBR_1=(diff_1)/(sum_1) 

# Get NBR for 28 August
diff_2= stack_swir2[[2]] - stack_swir2[[1]] # NIR - SWIR
sum_2= stack_swir2[[2]] + stack_swir2[[1]] # NIR + SWIR
NBR_2=(diff_2)/(sum_2) 

# Create a color palette (color blind people friendly) from viridis package
viridis<- viridis(100, option="plasma")

# Combine images in a stacksent array
stackNBR <- c(NBR_1,NBR_2)
names(stackNBR) <- c("8 August in NBR", "28 August in NBR")
plot(stackNBR, col=viridis, axes=FALSE)

# Delta NBR (dNBR) is used to evaluate burn severity
# Higher positive dNBR values indicate greater burn severity.
dNBR= (NBR_1) - (NBR_2) # Difference Pre - Post indicates high severity
plot(dNBR, col=viridis, main="dNBR") # Graph highlighting burnt area 

# Function im.classify() is used to identify levels of damage 
# Classification based on dNBR
classdnbr<- im.classify(dNBR, num_clusters= 3)
class.names<- c("Severely damaged areas", "Moderately damaged areas", "No damage") 
plot(classdnbr, main="Wildfire Damage Classification", type="classes", levels=class.names, col=viridis, axes=FALSE)

# To obtain values in %
freq<- freq(classdnbr) # Frequencies
tot<- ncell(classdnbr) # Total number of pixels
prop= freq/tot # Proportion
perc=prop*100 # Percentage
perc

# Severely damaged areas = 13%
# Moderately damaged areas = 12% 
# So, ~ 25% of the area visible in the image has been damaged by wildfires in August 2023.

## 2: Evaluating Vegetation Recovery Trends using NDVI

# June 2023 
b2j1<- rast("b2_j1.tiff") # B
b3j1<- rast("b3_j1.tiff") # G
b4j1<- rast("b4_j1.tiff") # R 
stack_j1<- c(b4j1, b3j1, b2j1) # create a stack

# June 2024
b2j2<- rast("b2_j2.tiff")
b3j2<- rast("b3_j2.tiff")
b4j2<- rast("b4_j2.tiff")
stack_j2<- c(b4j2, b3j2, b2j2) 

# June 2025
b2j3<- rast("b2_j3.tiff")
b3j3<- rast("b3_j3.tiff")
b4j3<- rast("b4_j3.tiff")
stack_j3<- c(b4j3, b3j3, b2j3) 

# Display using par(mfrow=)
par(mfrow=c(1,3), mar=c(5,2,10,2))
im.plotRGB(stack_j1,1,2,3, title="June 2023") # plot it in RGB 
im.plotRGB(stack_j2,1,2,3, title="June 2024") # plot it in RGB 
im.plotRGB(stack_j3,1,2,3, title="June 2025") # plot it in RGB 

# Import NIR band to create images in False Colors
# June 2023
b8j1<- rast("b8_j1.tiff") # NIR band
stack_j1fc<- c(b8j1, b4j1, b3j1) # Create a stack

# June 2024
b8j2<- rast("b8_j2.tiff")
stack_j2fc<- c(b8j2, b4j2, b3j2) 

# June 2025
b8j3<- rast("b8_j3.tiff")
stack_j3fc<- c(b8j3, b4j3, b3j3) 

# Calculation of spectral indices for vegetation
# NDVI is here used to assess how vegetation responds to disturbance caused by fire over time
# Expectations: NDVI in June 2023 is higher than NDVI in June 2024 but also in 2025. 

# DVI (Difference Vegetation Index) = NIR - RED
dvi1= stack_j1fc[[1]] - stack_j1fc[[2]]
dvi2= stack_j2fc[[1]] - stack_j2fc[[2]]
dvi3= stack_j3fc[[1]] - stack_j3fc[[2]]

# NDVI = DVI / (NIR + RED)
ndvi1= dvi1/ (stack_j1fc[[1]] + stack_j1fc[[2]])
ndvi2= dvi2/ (stack_j2fc[[1]] + stack_j2fc[[2]])
ndvi3= dvi3/ (stack_j3fc[[1]] + stack_j3fc[[2]])

# Comparison of images in a multiframe
par(mfrow=c(1,3))
plot(ndvi1, col=viridis, main="June 2023", axes=FALSE)
plot(ndvi2, col=viridis, main="June 2024", axes=FALSE)
plot(ndvi3, col=viridis, main="June 2025", axes=FALSE)


# NDVI-based Classification
# June 2023
cl1<- im.classify(ndvi1, num_clusters=2)
cl.names<- c("Healthy vegetation", "No vegetation and Artificial areas")

# June 2024 
cl2<- im.classify(ndvi2, num_clusters=2)
cl.names2<- c("Healthy vegetation", "Damaged vegetation and Artificial areas")

# June 2025
cl3<- im.classify(ndvi3, num_clusters=2)
cl.names3<- c("Healthy vegetation", "Damaged vegetation and Artificial areas")

# Display in multiframe
par(mfrow=c(1,3), mar=c(5,2,10,2) + c(2,5,2,0)) # Adjust margins and add space for legend and title
plot(cl1, main= "June 2023", type="classes", levels=cl.names, col=viridis(2), axes=FALSE, legend=FALSE)
plot(cl2, main= "June 2024", type="classes", levels=cl.names2, col=viridis(2), axes=FALSE, legend=FALSE)
legend("bottom",
       legend=c("Damaged vegetation and Artificial areas", "Healthy vegetation"),
       cex= 1,
       fill= viridis(2),  
       bty="n",           # No box around legend
       horiz= FALSE,      # Vertical legend
       xpd=TRUE)          # Legend outside the plot area
plot(cl3, main= "June 2025", type="classes", levels=cl.names3, col=viridis(2), axes=FALSE, legend=FALSE)

# Pixel quantification to get % of damaged and healthy vegetation 

# 2023
f1<- freq(cl1)
tot1<- ncell(cl1)
prop1= f1/tot1
perc1=prop1*100
perc1

#2024
f2<- freq(cl2)
tot2<- ncell(cl2)
prop2= f2/tot2
perc2=prop2*100
perc2

#2025
f3<- freq(cl3)
tot3<- ncell(cl3)
prop3= f3/tot3
perc3=prop3*100
perc3

# Dataframe with resulting percentages 
class<- c("Healthy vegetation", "Damaged vegetation and Artificial areas") # 1st column
june23<- c(71,29) # 2nd
june24<- c(44,55) # 3rd
june25<- c(59,41) # 4th
DF<- data.frame(class, june23, june24, june25)
DF # Recall to see dataframe 

# Plots are made with ggplot 

ggj23<- ggplot(DF, aes(x=class, y=june23)) +
    geom_bar(stat="identity", aes(fill=class), alpha=1) + 
    scale_fill_manual(values=c("Healthy vegetation"="#FDE725FF", "Damaged vegetation and Artificial areas"="#440154FF")) +
    ylim (c(0,100)) + ggtitle("June 2023") + ylab("%") +
    theme(plot.title=element_text(face="bold", hjust= 0.5), legend.position="none",
          axis.title.x = element_blank(),
      axis.text.x  = element_blank(),
      axis.ticks.x = element_blank())

ggj24 <- ggplot(DF, aes(x=class, y=june24)) +
    geom_bar(stat="identity", aes(fill=class), alpha=1) + 
    scale_fill_manual(values=c("Healthy vegetation"="#FDE725FF", "Damaged vegetation and Artificial areas"="#440154FF")) +
    ylim (c(0,100)) + ggtitle("June 2024") + ylab("%") +
    theme(plot.title=element_text(face="bold", hjust= 0.5), legend.position="none",
          axis.title.x = element_blank(),
      axis.text.x  = element_blank(),
      axis.ticks.x = element_blank())

ggj25 <- ggplot(DF, aes(x=class, y=june25)) +
    geom_bar(stat="identity", aes(fill=class), alpha=1) + 
    scale_fill_manual(values=c("Healthy vegetation"="#FDE725FF", "Damaged vegetation and Artificial areas"="#440154FF")) + 
    ylim (c(0,100)) + ggtitle("June 2025") + ylab("%") + 
    theme(plot.title=element_text(face="bold", hjust= 0.5),
          axis.title.x = element_blank(),
      axis.text.x  = element_blank(),
      axis.ticks.x = element_blank())

# aes() are the aestetics so what the two axis x and y rapresent 
# x is the class, healthy vegetation and damaged vegetation/artificial areas
# while y is the vegetation in %

# Combine plots using patchwork
ggj23 + ggj24 + ggj25

dev.off()


# Measuring Spatial Variability on NDVI images (Moving Window)

# Computing and visualizing Local Standars Deviation of NDVI using a moving window (3x3 and 7x7 pixels) 
# helps in capturing variations in vegetation from one location to another
# i.e. capturing spatial variability for June 2024 and 2025.

# 2024
j2_mw3x3 <- focal(ndvi2, w = matrix(1/9, 3, 3), fun = sd)
j2_mw7x7 <- focal(ndvi2, w = matrix(1/49, 7, 7), fun = sd)

# 2025 
j3_mw3x3 <- focal(ndvi3, w = matrix(1/9, 3, 3), fun = sd)
j3_mw7x7 <- focal(ndvi3, w = matrix(1/49, 7, 7), fun = sd)

# Comparison 3x3
plot(j2_mw3x3, main = "Local SD June 2024", col = viridis, axes=FALSE)
plot(j3_mw3x3, main = "Local SD June 2025", col = viridis, axes=FALSE)

# Comparison 7x7
plot(j2_mw7x7, main = "Local SD June 2024", col = viridis, axes=FALSE)
plot(j3_mw7x7, main = "Local SD June 2025", col = viridis, axes=FALSE)

# 3x3 MW provides better spatial resolution but less pronounced contrasts in terms of spatial varibility.
# 7x7 MW enhances visibility of broader spatial patterns thanks to a greater spatial averaging.
# Compared to SD values in 2024, SD values in 2025 tend to be lower suggesting reduced variability

dev.off()

# Conclusions:
# - Approximately 25% of the study area in southern Evros was moderately to severely damaged by the wildfire.
# - NBR and dNBR map burn severity effectively
# - NDVI shows a decline in 2024, followed by partial recovery of vegetation in 2025
# - Local Standard Deviation reveals differences in spatial variability between 2024 and 2025.

