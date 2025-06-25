# SPATIAL ECOLOGY IN R EXAM -  Student: MARIA ANTONIACCI (SGN)
# WILDFIRES in GREECE - August 2023 
# In August 2023, a massive wildfire broke out in the Evros region of northeastern Greece,
# spreading rapidly from the mountainous areas to the city of Alexandroupolis.
# Approximately 80,000 hectares of land were burned, including the forest within the Dadia–Lefkimi–Soufli Forest National Park.
# This event is considered to be the largest wildfire ever recorded in Europe since the year 2000.

# The project has two objectives, addressed through two analyses:
# 1: Assessing Pre and Post Wildfire Conditions using NBR
# 2: Evaluating Vegetation Health Trends for the years 2023, 2024, and 2025 using NDVI

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

# Display the images in a layout 1-row and 2-colums using par(mfrow=) plotting in RGB
par(mfrow= c(1,2))
im.plotRGB(stack_ago1,1,2,3, title="8 August") # plot it in RGB 
im.plotRGB(stack_ago2,1,2,3, title="28 August") # plot it in RGB
dev.off ()

# In general, to analyse images after wildfire NBR index is used
# NBR (Normalized Burn Ratio) is a normalized index that uses SWIR and NIR bands
# SWIR (Short-Wave InfraRed) shows high reflectance on burned vegetation and low reflectance of healthy vegetation.

# Import bands to get images so composed:
# First band 1 = SWIR or B12
# Second band 2 = NIR or B8
# Third band 3 = Red

# 8 August
b12_ago1 <- rast("b12_ago1.tiff") # SWIR
nir_ago1<- rast("nir_ago1.tiff") # NIR
b4_ago1<- rast("b4_ago1.tiff") # red
stack_swir1<- c(b12_ago1, nir_ago1, b4_ago1) # create a stack

# 28 August
b12_ago2 <- rast("b12_ago2.tiff") # SWIR
nir_ago2<- rast("nir_ago2.tiff") # NIR 
b4_ago2<- rast("b4_ago2.tiff") # red
stack_swir2<- c(b12_ago2, nir_ago2, b4_ago2) # create a stack

# Display side by side plotting in RGB
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

# Function im.classify() is used to identify three levels of damage 
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
# No damage = 75%
# So, almost 25% of the area visible in the image has been damaged by wildfires in August 2023.

## 2: Evaluating Vegetation Health Trends for the years 2023, 2024, and 2025 using NDVI

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
# NDVI is used to assess how vegetation responds to disturbance caused by fire over time
# Expectations: NDVI in June 2023 is higher than NDVI in June 2024 but also in 2025. 

# DVI (Difference Vegetation Index) = NIR - RED
dvi1= stack_j1fc[[1]] - stack_j1fc[[2]]
dvi2= stack_j2fc[[1]] - stack_j2fc[[2]]
dvi3= stack_j3fc[[1]] - stack_j3fc[[2]]

# NDVI = DVI / (NIR + RED)
ndvi1= dvi1/ (stack_j1fc[[1]] + stack_j1fc[[2]])
ndvi2= dvi2/ (stack_j2fc[[1]] + stack_j2fc[[2]])
ndvi3= dvi3/ (stack_j3fc[[1]] + stack_j3fc[[2]])

# Comparison of images side by side
par(mfrow=c(1,3), mar=c(5,2,10,2), oma=c(0,0,10,0))
plot(ndvi1, col=viridis, main="June 2023", axes=FALSE)
plot(ndvi2, col=viridis, main="June 2024", axes=FALSE)
plot(ndvi3, col=viridis, main="June 2025", axes=FALSE)
title("NDVI Comparison", outer=TRUE, cex.main=2)

# NDVI-based Classification
# June 2023
cl1<- im.classify(ndvi1, num_clusters=2)
cl.names<- c("Healthy vegetation", "No vegetation or Artificial areas")
plot(cl1, main= "June 2023", type="classes", levels=cl.names, col=viridis, axes=FALSE)

# June 2024 
cl2<- im.classify(ndvi2, num_clusters=2)
cl.names2<- c("Healthy vegetation", "Damaged vegetation and Artificial areas")
plot(cl2, main= "June 2024", type="classes", levels=cl.names2, col=viridis, axes=FALSE)

# June 2025
cl3<- im.classify(ndvi3, num_clusters=2)
cl.names3<- c("Healthy vegetation", "Damaged vegetation and Artificial areas")
plot(cl3, main= "June 2025", type="classes", levels=cl.names3, col=viridis, axes=FALSE)

# Display in par(mfrow=)
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

# Pixel quantification to get % 

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
DF # Recall to see the dataframe 

# Plots are made with ggplot 

ggj23<- ggplot(tabout, aes(x=class, y=june23)) +
    geom_bar(stat="identity", aes(fill=class), alpha=1) + 
    scale_fill_manual(values=c("Healthy vegetation"="#FDE725FF", "Damaged vegetation and Artificial areas"="#440154FF")) +
    ylim (c(0,100)) + ggtitle("June 2023") + ylab("%") +
    theme(plot.title=element_text(face="bold", hjust= 0.5), legend.position="none",
          axis.title.x = element_blank(),
      axis.text.x  = element_blank(),
      axis.ticks.x = element_blank())

ggj24 <- ggplot(tabout, aes(x=class, y=june24)) +
    geom_bar(stat="identity", aes(fill=class), alpha=1) + 
    scale_fill_manual(values=c("Healthy vegetation"="#FDE725FF", "Damaged vegetation and Artificial areas"="#440154FF")) +
    ylim (c(0,100)) + ggtitle("June 2024") + ylab("%") +
    theme(plot.title=element_text(face="bold", hjust= 0.5), legend.position="none",
          axis.title.x = element_blank(),
      axis.text.x  = element_blank(),
      axis.ticks.x = element_blank())

ggj25 <- ggplot(tabout, aes(x=class, y=june25)) +
    geom_bar(stat="identity", aes(fill=class), alpha=1) + 
    scale_fill_manual(values=c("Healthy vegetation"="#FDE725FF", "Damaged vegetation and Artificial areas"="#440154FF")) + 
    ylim (c(0,100)) + ggtitle("June 2025") + ylab("%") + 
    theme(plot.title=element_text(face="bold", hjust= 0.5),
          axis.title.x = element_blank(),
      axis.text.x  = element_blank(),
      axis.ticks.x = element_blank())

# Combine plots using patchwork 
ggj23 + ggj24 + ggj25

dev.off()

# Measuring spectral variability from June 2023 to June 2025
# High variability can be associated to habitat fragmentation and landscape heterogeneity caused by wildfires 

# PCA (Principal Component Analyses) to extract the most informative component explaning variability
# PCA is based on NDVI values
# The approach is useful for visualizing fire impact and vegetation recovery in a single map

# Combining NDVI rasters from the three years into a multiband object 
# Allows pixel-to-pixel comparison across time

ndvi_stack <- c(ndvi1, ndvi2, ndvi3)
names(ndvi_stack) <- c("NDVI_2023", "NDVI_2024", "NDVI_2025") # Assign layer names for clarity

# Perform PCA across NDVI layers
ndvi_pca <- im.pca(ndvi_stack)

#               PC1         PC2        
# NDVI_2023 0.5799648  0.76215215  
# NDVI_2024 0.6150644 -0.64122968  
# NDVI_2025 0.5341691 -0.08915495 

# PC1 shows dominant trends across time:
# If PC1 shows light areas => High NDVI => healthy or recovering vegetation 
# If PC1 shows dark areas => Low NDVI => degradated vegetation.
# PC2 reveals significative local anomalies due to wildfire consequences in 2024 (negative values) 

# Display NDVI plot across time only considering PC1 and PC2
plot(ndvi_pca[[1:2]], col=viridis, main=c("PC1", "PC2"), axes=FALSE)

# Analysis of Local Standard Deviation (SD) to identify areas with higher spatial and temporal variation
# SD is calculated using Moving Windows method (MW) applied to PC1
# MW 3x3
pc1_sd <- focal(ndvi_pca$PC1, w = matrix(1/9, 3, 3), fun = sd)
plot(pc1_sd, main = "Local SD of PC1 3x3 MW", col = viridis)

# MW 7x7 
pc1_sd <- focal(ndvi_pca$PC1, w = matrix(1/49, 7, 7), fun = sd)
plot(pc1_sd, main = "Local SD of PC1 7x7 MW", col = viridis)

# Higher values of SD => higher local variability => potentially at risk areas
# Lower values of SD => stable areas => greater potential of consistent recovery 
# 3x3 MW provides better spatial resolution but less pronounced spectral varibility
# 7x7 MW enhances contrast, making spatial patterns of variability more evident

# Conclusions:
# - Wildfire damaged ~25% of Evros area in August 2023.
# - NBR maps burn severity effectively.
# - NDVI shows vegetation decline in 2024 and partial recovery in 2025.
# - PCA highlights main vegetation trends and fire impact across time. 
# - Local SD identifies areas with high variability and recovery potential.
# - Multitemporal analysis is key for monitoring fire effects and vegetation recovery.

