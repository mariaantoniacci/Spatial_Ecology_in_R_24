## GOLD MINING IN YANOMAMI REGION##

library(terra)
y2016<- flip(rast("Yanomami_nov2016.jpg"))
y2023<-flip(rast("Yanomami_sept2023.jpg"))

library(imageRy)
par(mfrow=c(1,2))
plot(y2016)
plot(y2023)
dev.off()

# TRUE COLOURS
# band 1= RED (b4)
# band 2= GREEN (b3)
# band 3= BLUE (b2)
par(mfrow=c(1,2))
im.plotRGB(y2016, r=1, g=2, b=3, title="2016")
im.plotRGB(y2023, r=1, g=2, b=3, title="2023")

#FALSE COLOURS
# band 1=NIR (b8)
# band 2=RED (b4)
# band 3=GREEN (b3)
y2016FC<-flip(rast("Y_2016_FC.jpg"))
y2023FC<-flip(rast("Y_sept23_FC.jpg"))

par(mfrow=c(1,2))
plot(y2016FC, main="2016")
plot(y2023FC, main="2023")

# CHANGING NIR POSITION
# NIR on blue with blue on red
im.plotRGB(y2023FC, 3,2,1)
im.plotRGB(y2016FC, 3,2,1)

# NIR on green but with green on red and blue on green
im.plotRGB(y2016FC, 2,3,1)
im.plotRGB(y2023FC, 2,3,1)

# DVI 2016
dvi2016= y2016FC[[1]] - y2016FC[[2]]
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)
plot(dvi2016, col=cl)

# DVI 2023
dvi2023= y2023FC[[1]] - y2023FC[[2]]
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)
plot(dvi2023, col=cl)

# NDVI 2016 E 2023
ndvi2016 = dvi2016 / (y2016FC[[1]]+y2016FC[[2]])
ndvi2023 = dvi2023 / (y2023FC[[1]]+y2023FC[[2]])

par(mfrow=c(1,2))
plot(ndvi2016, col=cl)
plot(ndvi2023, col=cl)

# FIRST TRY: MASKING THE CLOUD WITH NDSI
# we need SWIR band for this
# on copernicus SWIR is band b12, b8a, b4
b42016<-rast("2016_b4.tiff")
b122016<- rast("2016_b12.tiff")
b8a2016<- rast("2016_b8a.tiff")
stackswir<- c( b122016,b8a2016,b42016)
# to have all bands in a single image 
im.plotRGB(stackswir, 1,2,3)

# now try to calculate NDSI
# NDSI <- (band_green - band_SWIR) / (band_green + band_SWIR)
b32016<-rast("2016_B3.tiff")
NDSI2016<- (b32016-stackswir)/(b32016+stackswir)

# error

# Controlla l'estensione e la risoluzione
ext(b32016)
# SpatExtent : -63.3248519897461, -63.138427734375, 3.57767084568741, 3.69673517133588 (xmin, xmax, ymin, ymax)
ext(b112016)
# SpatExtent : -63.3181228616741, -63.131698606303, 3.58232958498001, 3.70139329487712 (xmin, xmax, ymin, ymax)
res(b32016)
# [1] 0.0001797727 0.0001793137
res(b112016)
# [1] 0.0001797727 0.0001793128

 b112016_resampled <- resample(b112016, b32016)
# Calcola l'NDSI
NDSI <- (b32016 - b112016_resampled) / (b32016 + b112016_resampled)
# Visualizza il risultato
plot(NDSI)
nuvole_mask <- NDSI > 0.4
raster_senza_nuvole <- mask(b32016, nuvole_mask) # ottengo un'immagine in cui è evidente la nuvola

#se plotto
nuvole<- NDSI> 0.4
plot(nuvole) # ottengo una immagine di True e False 
