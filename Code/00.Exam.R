# WILDFIRES in GREECE - August 2023 
# In August 2023, a massive wildfire broke out in the Evros region of northeastern Greece,
# spreading rapidly from the mountainous areas to the city of Alexandroupolis.
# Approximately 80,000 hectares of land were burned, including the forest within the Dadia–Lefkimi–Soufli Forest National Park.
# This event is considered to be the largest wildfire ever recorded in Europe since the year 2000.

# AIM 1: PRE AND POST FIRES with NBR
# AIM 2: VEGETATION HEALTH with NDVI

setwd("C:/SPATIAL ECOLOGY IN R")
library(terra)
library(imageRy)
library(viridis)
library(ggplot2)
library(patchwork)

### ago 1 vs ago 2 = pre and post fires 

# import bands for ago 1 in TC
b2_ago1 <- rast("b2_ago1.tiff") # blue
b3_ago1<- rast("b3_ago1.tiff") # green 
b4_ago1<- rast("b4_ago1.tiff") # red
stack_ago1<- c(b4_ago1, b3_ago1, b2_ago1) # create a stack
im.plotRGB(stack_ago1,1,2,3, title="8 August") # plot it in RGB 

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

# other bands needed is swir where
# 1 = swir or b12
# 2 = nir or b8
# 3 = red

# using .tiff from copernicus ago 1
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

# Ago 1 NBR
diff_1= stack_swir1[[2]] - stack_swir1[[1]]
sum_1= stack_swir1[[2]] + stack_swir1[[1]]
NBR_1=(diff_1)/(sum_1)

# Ago 2
diff_2= stack_swir2[[2]] - stack_swir2[[1]]
sum_2= stack_swir2[[2]] + stack_swir2[[1]]
NBR_2=(diff_2)/(sum_2)

# visualize
stackNBR <- c(NBR_1,NBR_2)
names(stackNBR) <- c("8 August", "28 August")
plot(stackNBR, col=viridis, axes=FALSE)

# dNBR .tiff
dNBR= (NBR_1) - (NBR_2)
plot(dNBR, col=viridis, main="dNBR")

# TO VISUALIZE different shades of damage 3 clusters
classdnbr<- im.classify(dNBR, num_clusters= 3)
class.names<- c("Heavily damaged area", "Moderately damaged area", "No damage") 
plot(classdnbr, main="Wildfire Damage Classification", type="classes", levels=class.names, col=viridis, axes=FALSE)

# calculate %s
freq<- freq(classdnbr)
tot<- ncell(classdnbr)
prop= freq/tot
perc=prop*100
perc
# heavily = 13%
# moderately = 12% 
# no damage = 74.8%
# so the 25% of the area visible in the image has been damaged by wildfires, an extensive area of the Evron region  
# it is almost an area as New York city 

# now use ndvi to see how the vegetation is responding to the impact in two following years
# we expect that NDVI from June 2023 is higher than NDVI June 2024 but also than 2025. 

# let's visualize first june 23, june 24 and june 25
# june 23
b2j1<- rast("b2_j1.tiff")
b3j1<- rast("b3_j1.tiff")
b4j1<- rast("b4_j1.tiff")
stack_j1<- c(b4j1, b3j1, b2j1) # create a stack
im.plotRGB(stack_j1,1,2,3, title="June 2023") # plot it in RGB 

# june 24
b2j2<- rast("b2_j2.tiff")
b3j2<- rast("b3_j2.tiff")
b4j2<- rast("b4_j2.tiff")
stack_j2<- c(b4j2, b3j2, b2j2) # create a stack
im.plotRGB(stack_j2,1,2,3, title="June 2024") # plot it in RGB 

#june 25
b2j3<- rast("b2_j3.tiff")
b3j3<- rast("b3_j3.tiff")
b4j3<- rast("b4_j3.tiff")
stack_j3<- c(b4j3, b3j3, b2j3) # create a stack
im.plotRGB(stack_j3,1,2,3, title="June 2025") # plot it in RGB 

# visualize together
par(mfrow=c(1,3), mar=c(5,2,10,2))
im.plotRGB(stack_j1,1,2,3, title="June 2023") # plot it in RGB 
im.plotRGB(stack_j2,1,2,3, title="June 2024") # plot it in RGB 
im.plotRGB(stack_j3,1,2,3, title="June 2025") # plot it in RGB 

# let's import images in false colors (NIR)
# june 23
b8j1<- rast("b8_j1.tiff")
stack_j1fc<- c(b8j1, b4j1, b3j1) # create a stack

# june 24
b8j2<- rast("b8_j2.tiff")
stack_j2fc<- c(b8j2, b4j2, b3j2) # create a stack

#june 25
b8j3<- rast("b8_j3.tiff")
stack_j3fc<- c(b8j3, b4j3, b3j3) # create a stack

dvi1= stack_j1fc[[1]] - stack_j1fc[[2]]
dvi2= stack_j2fc[[1]] - stack_j2fc[[2]]
dvi3= stack_j3fc[[1]] - stack_j3fc[[2]]

# NDVI
ndvi1= dvi1/ (stack_j1fc[[1]] + stack_j1fc[[2]])
ndvi2= dvi2/ (stack_j2fc[[1]] + stack_j2fc[[2]])
ndvi3= dvi3/ (stack_j3fc[[1]] + stack_j3fc[[2]])

par(mfrow=c(1,3), mar=c(5,2,10,2))
plot(ndvi1, col=viridis, main="June 2023")
plot(ndvi2, col=viridis, main="June 2024")
plot(ndvi3, col=viridis, main="June 2025")

# classify im.classify
#june 23
cl1<- im.classify(ndvi1, num_clusters=2)
cl.names<- c("Healthy vegetation", "No vegetation or Artificial areas")
plot(cl1, main= "June 2023", type="classes", levels=cl.names, col=viridis, axes=FALSE)

# june 24 
cl2<- im.classify(ndvi2, num_clusters=2)
cl.names2<- c("Healthy vegetation", "Damaged vegetation and Artificial areas")
plot(cl2, main= "June 2024", type="classes", levels=cl.names2, col=viridis, axes=FALSE)

# june 25
cl3<- im.classify(ndvi3, num_clusters=2)
cl.names3<- c("Healthy vegetation", "Damaged vegetation and Artificial areas")
plot(cl3, main= "June 2025", type="classes", levels=cl.names3, col=viridis, axes=FALSE)

# visualize 

cl3 <- subst(cl3, from = c(1, 2), to = c(2, 1))  # ora 1 = damaged, 2 = healthy
par(mfrow=c(1,3), mar=c(5,2,10,2) + c(2,5,2,0))
plot(cl1, main= "June 2023", type="classes", levels=cl.names, col=viridis(2), axes=FALSE, legend=FALSE)
plot(cl2, main= "June 2024", type="classes", levels=cl.names2, col=viridis(2), axes=FALSE, legend=FALSE)
plot(cl3, main= "June 2025", type="classes", levels=cl.names3, col=viridis(2), axes=FALSE, legend=FALSE)
legend("bottomleft",
       legend=c("Damaged vegetation and Artificial areas", "Healthy vegetation"),
       fill= viridis(2),
       bty="n",
       horiz= FALSE,
       xpd=TRUE)


# to get the %s

f1<- freq(cl1)
tot1<- ncell(cl1)
prop1= f1/tot1
perc1=prop1*100
perc1

f2<- freq(cl2)
tot2<- ncell(cl2)
prop2= f2/tot2
perc2=prop2*100
perc2

f3<- freq(cl3)
tot3<- ncell(cl3)
prop3= f3/tot3
perc3=prop3*100
perc3

# creating a tabout
class<- c("Healthy vegetation", "Damaged vegetation and Artificial areas")
june23<- c(71,29)
june24<- c(44,55)
june25<- c(59,41)

tabout<- data.frame(class, june23, june24, june25)
tabout 

# visulize data graphically with GGPLOT2 and patchwork
# to analyze the restorantion dynamics of vegetated areas comparing june 23,24,25 ndvi 

# tabout con classificazioni basate su ndvi1,2,3

ggj23<- ggplot(tabout, aes(x=class, y=june23)) +
    geom_bar(stat="identity", aes(fill=class), alpha=1) + 
    scale_fill_manual(values=c("Healthy vegetation"= "darkolivegreen", "Damaged vegetation and Artificial areas"="firebrick"))+  ylim (c(0,100))+
    ggtitle("June 2023") + ylab("%") +
    theme(plot.title=element_text(face="bold", hjust= 0.5), legend.position="none",
          axis.title.x = element_blank(),
      axis.text.x  = element_blank(),
      axis.ticks.x = element_blank())

ggj24 <- ggplot(tabout, aes(x=class, y=june24)) +
    geom_bar(stat="identity", aes(fill=class), alpha=1) + 
    scale_fill_manual(values=c("Healthy vegetation"= "darkolivegreen", "Damaged vegetation and Artificial areas"="firebrick"))+  ylim (c(0,100))+
    ggtitle("June 2024") + ylab("%") +
    theme(plot.title=element_text(face="bold", hjust= 0.5), legend.position="none",
          axis.title.x = element_blank(),
      axis.text.x  = element_blank(),
      axis.ticks.x = element_blank())

ggj25 <- ggplot(tabout, aes(x=class, y=june25)) +
    geom_bar(stat="identity", aes(fill=class), alpha=1) + 
    scale_fill_manual(values=c("Healthy vegetation"= "darkolivegreen", "Damaged vegetation and Artificial areas"="firebrick"))+  ylim (c(0,100))+
    ggtitle("June 2025") + ylab("%") + 
    theme(plot.title=element_text(face="bold", hjust= 0.5),
          axis.title.x = element_blank(),
      axis.text.x  = element_blank(),
      axis.ticks.x = element_blank())

# visulize graphs together with patchwork 
ggj23 + ggj24 + ggj25

dev.off()

# measuring spectral variability  during june 23,24,25
# higher variability can be associated to habitat frammentation and heterogeneity due to the wildfire 

# we calculate the most informative variable that explains better the variability
# we perform a PCA on ndvi
# useful to map in a single map impacts and recovery post-fire

# let's combine ndvis from three years in a single multibands object 
# so each NDVI per year is compared pixel to pixel

ndvi_stack <- c(ndvi1, ndvi2, ndvi3)
names(ndvi_stack) <- c("NDVI_2023", "NDVI_2024", "NDVI_2025")

# perform PCA on stack, so performing pca on each band
ndvi_pca <- im.pca(ndvi_stack)

#               PC1         PC2        
# NDVI_2023 0.5799648  0.76215215  
# NDVI_2024 0.6150644 -0.64122968  
# NDVI_2025 0.5341691 -0.08915495 

# where pc1 is the dominant shared trends
# if PC1 shows light areas=> High NDVI=> healthy or recovering vegetation in all three years
# if PC1 shows dark areas=> Low NDVI=> degradated vegetation during the years 
# PC2 reveals significative local anomalies due to wildfire consequences in 2024 (negative values) 

# visualize resulting maps
plot(ndvi_pca, col=viridis(100), main=c("PC1", "PC2", "PC3"))

# now let's analyse local SD to understand where is the higher local variation or fluctuactions in time
# we calculate SD with moving windows method using PC1
# MW 3x3
pc1_sd <- focal(ndvi_pca[[1]], w = matrix(1/9, 3, 3), fun = sd)
plot(pc1_sd, main = "Local SD of PC1", col = viridis(100))

# MW 7x7 
pc1_sd <- focal(ndvi_pca[[1]], w = matrix(1/49, 7, 7), fun = sd)
plot(pc1_sd, main = "Local SD of PC1", col = viridis(100))

# higher values=> higher local variability=> potentially at risk 
# lower values=> stable areas0> higher potential of stable recovery 
# MW 3x3 better resolution but less accetuated spectral varibility
# with MW 7x7 contrasts are clearer

# Conclusions:
# significative recovery of vegetation as shown by PC1 
# NDVI between 23 and 24 varies significantly due to fires as shown by PC2


### USING JPG INSTEAD OF TIFF
tc_1 <- flip(rast("tc1_jpg.jpg"))
tc_2<- flip(rast("tc2_jpg.jpg"))

# to visualize in TC.jpg
par(mfrow=c(1,2))
plot(tc_1)
title("8 August", line= 2, cex=2)
plot(tc_2)
title("28 August", line=2, cex=2)

dev.off()
# or  using.jpg
swir1<- flip(rast("swir1_jpg.jpg"))
swir2<- flip(rast("swir2_jpg.jpg"))

# to visualise jpg
par(mfrow=c(1,2))
plot(swir1, main="8 August in SWIR")
plot(swir2, main="28 August in SWIR")

# Ago 1 NBR jpg
diff_1= swir1[[2]] - swir1[[1]]
sum_1= swir1[[2]] + swir1[[1]]
NBR_1=(diff_1)/(sum_1)

# Ago 2 NBR jpg
diff_2= swir2[[2]] - swir2[[1]]
sum_2= swir2[[2]] + swir2[[1]]
NBR_2=(diff_2)/(sum_2)

# visualize in jpg 
viridis <- plasma(100)
par(mfrow=c(1,2))
plot(NBR_1, col=viridis)
plot(NBR_2, col=viridis)




# classify to see % of heallthy vegetation after the wildfire impacts
before<- im.classify(ndvi1, num_clusters=2)
class.names<- c("Vegetation in good state", "Non vegetated natural areas")
plot(before, main= "June 2023", type="classes", levels=class.names, col=cl)

f23<- freq(before)
tot23<- ncell(before)
prop23= f23/tot23
perc23=prop23*100
perc23

# vegetated natural areas= 85% 
# non vegetated or non natural areas= 15%

# June 25
after<- im.classify(ndvi2, num_clusters=3)
class.names2<- c("Vegetation in good state/Natural areas", " Impacted by wildfire", "Artificial areas")
plot(after, main= "June 2025", type="classes", levels=class.names2, col=c("yellow", "orange", "purple"))

after<- im.classify(ndvi2, num_clusters=)
class.names2<- c("Vegetation in good state/Natural areas", " Impacted by wildfire")
plot(after, main= "June 2025", type="classes", levels=class.names2, col=c("yellow", "purple"))

# 2023, 2024, 2025

tcj1<- flip(rast("tc_j1_jpg.jpg"))
tcj3<-flip(rast("tc_j3_jpg.jpg"))
tcj2<- flip(rast("tc_j2_jpg.jpg"))
par(mfrow=c(1,3))
plot(tcj1, main="June 2023")
plot(tcj3, main="June 2024")
plot(tcj2, main="June 2025")


ndvi1<- flip(rast("ndvi_j1_jpg.jpg"))
ndvi3<- flip(rast("ndvi_j3_jpg.jpg"))
ndvi2<- flip(rast("ndvi_j2_jpg.jpg"))
par(mfrow=c(1,3))
plot(ndvi1, main="June 2023 NDVI")
plot(ndvi3, main="June 2024 NDVI")
plot(ndvi2, main="June 2025 NDVI")

# 2023
before<- im.classify(ndvi1, num_clusters=3)
class.names<- c("Vegetation in good state/Natural areas", " Moderately good", "Artificial areas")
plot(before, main= "June 2023", type="classes", levels=class.names, col=c("yellow", "orange", "purple"))

freq23<- freq(before)
tot23<- ncell(before)
prop23= freq23/tot23
perc23=prop23*100
perc23

# good stated= 79%
# moderately good= 14%
# artficial= 7%

# 2024
a1<- im.classify(ndvi3, num_clusters=3)
class.names1<- c("Vegetation in good state", "Impacted areas", "Artificial areas")
plot(a1, main= "June 2024", type="classes", levels=class.names1, col=c("yellow", "orange", "purple"))

freq24<- freq(a1)
tot24<- ncell(a1)
prop24= freq24/tot24
perc24=prop24*100
perc24

# 27%
# 50%
# 23%

# 2025
a2<- im.classify(ndvi2, num_clusters=3)
class.names2<- c("Vegetation in good state", "Impacted areas", "Artificial areas")
plot(a2, main= "June 2025", type="classes", levels=class.names2, col=c("yellow", "orange", "purple"))

legend("bottom", legend=c("Vegetation in good state", "Impacted areas", "Artificial areas"), fill=c("yellow", "orange", "purple"), 
inset=c(0, -0.5), bty="n", horiz= TRUE)

freq25<- freq(a2)
tot25<- ncell(a2)
prop25= freq25/tot25
perc25=prop25*100
perc25

# 65%
# 13%
# 22%

par(mfrow=c(1, 3), mar = c(0, 0, 4, 2), oma = c(5, 0, 2, 0))
plot(before, main= "June 2023", type="classes", levels=class.names, col=c("yellow", "orange", "purple"), axes=FALSE, legend=FALSE)
plot(a1, main= "June 2024", type="classes", levels=class.names1, col=c("yellow", "orange", "purple"), axes=FALSE, legend= FALSE)
plot(a2, main= "June 2025", type="classes", levels=class.names2, col=c("yellow", "orange", "purple"), axes=FALSE, legend= FALSE)

par(xpd=NA)

# Aggiungi legenda centrata sotto i plot
legend("bottom", inset=-0.4, horiz=TRUE, bty="n", cex=1,
       legend=class.names, fill=colors)

colors<- c("yellow", "orange", "purple")
par(mfrow = c(1,3))      # reset layout
par(xpd = TRUE)          # permette di disegnare fuori dalla finestra del plot
legend("bottom",
       xpd= TRUE,
       legend = c(class.names,class.names1, class.names2),
       fill = colors,
       horiz = TRUE,
       inset = c(0, -0.5),
       bty = "n",
       cex = 1)
