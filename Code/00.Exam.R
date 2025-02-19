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


# 19.02
> ## GOLD MINING IN YANOMAMI REGION##
> 
> library(terra)
terra 1.8.21
Messaggio di avvertimento:
il pacchetto ‘terra’ è stato creato con R versione 4.4.2 
> y2016<- flip(rast("Yanomami_nov2016.jpg"))
Errore in h(simpleError(msg, call)) : 
  errore durante la valutazione dell'argomento 'x' nella selezione di un metodo per la funzione 'flip': [rast] file does not exist: Yanomami_nov2016.jpg
In aggiunta: Messaggio di avvertimento:
Yanomami_nov2016.jpg: No such file or directory (GDAL error 4) 
> getwd()
[1] "C:/Users/anton/OneDrive/Documents"
> setwd("C:/SPATIAL ECOLOGY IN R")
> library(terra)
> y2016<- flip(rast("Yanomami_nov2016.jpg"))
Messaggio di avvertimento:
[rast] unknown extent 
> 2016_b2<- rast("2016_b2")
Errore: input inatteso in "2016_"
> b2_2016<- rast("2016_b2")
Errore: [rast] file does not exist: 2016_b2
In aggiunta: Messaggio di avvertimento:
2016_b2: No such file or directory (GDAL error 4) 
> b2_2016<- rast("2016_b2.tiff")
> b3_2016<- rast("2016_b3.tiff")
> b4<- rast("2016_b4.tiff")
> stack16<- c(b4,b3,b2)
Errore: oggetto 'b3' non trovato
> b4_2016<- rast("2016_b4.tiff")
> stack16<- c(b4_2016,b3_2016,b2_2016)
Errore: [rast] extents do not match
> ext(b4_2016)
SpatExtent : -63.3181228616741, -63.131698606303, 3.58232958498001, 3.70139329487712 (xmin, xmax, ymin, ymax)
> ext(b3_2016)
SpatExtent : -63.3248519897461, -63.138427734375, 3.57767084568741, 3.69673517133588 (xmin, xmax, ymin, ymax)
> b1_16<- raster("T20NMK_20161130T143752_B02_20m.jp2")
Errore in raster("T20NMK_20161130T143752_B02_20m.jp2") : 
  non trovo la funzione "raster"
> library(terra)
> b1_16<- rast("T20NMK_20161130T143752_B02_20m.jp2")
> b2_16<- rast("T20NMK_20161130T143752_B03_20m.jp2")
> b3_16<- rast("T20NMK_20161130T143752_B04_20m.jp2")
> stack16<- c(b4_16, b3_16, b2_16)
Errore: oggetto 'b4_16' non trovato
> b2_16<- rast("T20NMK_20161130T143752_B02_20m.jp2")
> b3_16<- rast("T20NMK_20161130T143752_B03_20m.jp2")
> b4_16<- rast("T20NMK_20161130T143752_B04_20m.jp2")
> stack16<- c(b4_16, b3_16, b2_16)
> im-plotRGB(stack16, 1,2,3)
Errore: oggetto 'im' non trovato
> im.plotRGB(stack16, 1,2,3)
Errore in im.plotRGB(stack16, 1, 2, 3) : 
  non trovo la funzione "im.plotRGB"
> library(imageRy)
> im.plotRGB(stack16, 1,2,3)
> ext(stack16)
SpatExtent : 399960, 509760, 390240, 500040 (xmin, xmax, ymin, ymax)
> e <- ext(454860, 509760, 445140, 500040)
> test1<- crop(stack16,e)
> plot(test1)
> plot(stack(test1))
Errore in h(simpleError(msg, call)) : 
  errore durante la valutazione dell'argomento 'x' nella selezione di un metodo per la funzione 'plot': almeno un elemento vettore è richiesto
> plot(stack(test1[1],[2],[3]))
Errore: '[' inatteso in "plot(stack(test1[1],["
> plot(stack(test1,[1],[2],[3]))
Errore: '[' inatteso in "plot(stack(test1,["
> plot(stack(test1,[1][2][3]))
Errore: '[' inatteso in "plot(stack(test1,["
> plot(stack(test1[1][2][3]))
Errore in h(simpleError(msg, call)) : 
  errore durante la valutazione dell'argomento 'x' nella selezione di un metodo per la funzione 'plot': selezionate colonne non definite
> test1[1][2][3])
Errore: ')' inatteso in "test1[1][2][3])"
> im.plotRGB(test1,1,2,3)
> str(stack16)
S4 class 'SpatRaster' [package "terra"]
> crs(stack16)
[1] "PROJCRS[\"WGS 84 / UTM zone 20N\",\n    BASEGEOGCRS[\"WGS 84\",\n        ENSEMBLE[\"World Geodetic System 1984 ensemble\",\n            MEMBER[\"World Geodetic System 1984 (Transit)\"],\n            MEMBER[\"World Geodetic System 1984 (G730)\"],\n            MEMBER[\"World Geodetic System 1984 (G873)\"],\n            MEMBER[\"World Geodetic System 1984 (G1150)\"],\n            MEMBER[\"World Geodetic System 1984 (G1674)\"],\n            MEMBER[\"World Geodetic System 1984 (G1762)\"],\n            MEMBER[\"World Geodetic System 1984 (G2139)\"],\n            MEMBER[\"World Geodetic System 1984 (G2296)\"],\n            ELLIPSOID[\"WGS 84\",6378137,298.257223563,\n                LENGTHUNIT[\"metre\",1]],\n            ENSEMBLEACCURACY[2.0]],\n        PRIMEM[\"Greenwich\",0,\n            ANGLEUNIT[\"degree\",0.0174532925199433]],\n        ID[\"EPSG\",4326]],\n    CONVERSION[\"UTM zone 20N\",\n        METHOD[\"Transverse Mercator\",\n            ID[\"EPSG\",9807]],\n        PARAMETER[\"Latitude of natural origin\",0,\n            ANGLEUNIT[\"degree\",0.0174532925199433],\n            ID[\"EPSG\",8801]],\n        PARAMETER[\"Longitude of natural origin\",-63,\n            ANGLEUNIT[\"degree\",0.0174532925199433],\n            ID[\"EPSG\",8802]],\n        PARAMETER[\"Scale factor at natural origin\",0.9996,\n            SCALEUNIT[\"unity\",1],\n            ID[\"EPSG\",8805]],\n        PARAMETER[\"False easting\",500000,\n            LENGTHUNIT[\"metre\",1],\n            ID[\"EPSG\",8806]],\n        PARAMETER[\"False northing\",0,\n            LENGTHUNIT[\"metre\",1],\n            ID[\"EPSG\",8807]]],\n    CS[Cartesian,2],\n        AXIS[\"(E)\",east,\n            ORDER[1],\n            LENGTHUNIT[\"metre\",1]],\n        AXIS[\"(N)\",north,\n            ORDER[2],\n            LENGTHUNIT[\"metre\",1]],\n    USAGE[\n        SCOPE[\"Navigation and medium accuracy spatial referencing.\"],\n        AREA[\"Between 66°W and 60°W, northern hemisphere between equator and 84°N, onshore and offshore. Anguilla. Antigua and Barbuda. Bermuda. Brazil. British Virgin Islands. Canada - New Brunswick; Labrador; Nova Scotia; Nunavut; Prince Edward Island; Quebec. Dominica. Greenland. Grenada. Guadeloupe. Guyana. Martinique. Montserrat. Puerto Rico. St Kitts and Nevis. St Barthelemy. St Lucia. St Maarten, St Martin. St Vincent and the Grenadines. Trinidad and Tobago. Venezuela. US Virgin Islands.\"],\n        BBOX[0,-66,84,-60]],\n    ID[\"EPSG\",32620]]"
> library(terra)
> 
> # Definisci l'extent dell'immagine in UTM zona 20N
> e_utm <- ext(399960, 509760, 390240, 500040)
> 
> # Definisci il CRS di origine (UTM zona 20N)
> crs_utm <- "EPSG:32620"  # UTM zona 20N
> 
> # Definisci il CRS di destinazione (WGS 84)
> crs_wgs84 <- "EPSG:4326"  # WGS 84 (Latitudine e Longitudine)
> 
> # Crea un oggetto SpatialPoints per la trasformazione
> extent_raster <- rast(nrows=1, ncols=1, ext=e_utm, crs=crs_utm)
> 
> # Converti l'extent da UTM a WGS 84 (Lat/Long)
> extent_wgs84 <- project(extent_raster, crs_wgs84)
> 
> # Estrai le coordinate minime e massime dopo la trasformazione
> xmin_wgs84 <- xmin(extent_wgs84)
> xmax_wgs84 <- xmax(extent_wgs84)
> ymin_wgs84 <- ymin(extent_wgs84)
> ymax_wgs84 <- ymax(extent_wgs84)
> 
> # Visualizza le nuove coordinate in latitudine e longitudine
> cat("Nuovo extent in WGS 84 (Lat/Long):\n")
Nuovo extent in WGS 84 (Lat/Long):
> cat("xmin =", xmin_wgs84, " , xmax =", xmax_wgs84, "\n")
xmin = -63.90179  , xmax = -62.91056 
> cat("ymin =", ymin_wgs84, " , ymax =", ymax_wgs84, "\n")
ymin = 3.532697  , ymax = 4.523924 
> 
> library(terra)
> 
> # Definisci l'extent con le coordinate geografiche (Lat/Long)
> e_wgs84 <- ext(-63.31080, -63.13003, 3.53774, 3.71831)
> 
> # Definisci il CRS di origine (WGS 84)
> crs_wgs84 <- "EPSG:4326"  # Coordinate geografiche (Latitudine/Longitudine)
> 
> # Definisci il CRS di destinazione (UTM zona 20N)
> crs_utm <- "EPSG:32620"  # UTM zona 20N
> 
> # Crea un oggetto raster per il calcolo della trasformazione
> raster_extent <- rast(nrows=1, ncols=1, ext=e_wgs84, crs=crs_wgs84)
> 
> # Converte l'extent in UTM zona 20N
> e_utm <- project(raster_extent, crs_utm)
> 
> # Estrai le nuove coordinate UTM dopo la trasformazione
> xmin_utm <- xmin(e_utm)
> xmax_utm <- xmax(e_utm)
> ymin_utm <- ymin(e_utm)
> ymax_utm <- ymax(e_utm)
> 
> # Visualizza le nuove coordinate UTM
> cat("Nuovo extent in UTM zona 20N:\n")
Nuovo extent in UTM zona 20N:
> cat("xmin =", xmin_utm, " , xmax =", xmax_utm, "\n")
xmin = 465481  , xmax = 485498.4 
> cat("ymin =", ymin_utm, " , ymax =", ymax_utm, "\n")
ymin = 390979.4  , ymax = 410996.8 
> 
> e<- ext(465481,485498.4,390979.4,410996.8)
> test2<- crop(stack16,e)
> im.plotRGB(test2,1,2,3)
> cldmsk<- rast("MSK_CLDPRB_20m.jp2")
> cldmsk_cropped<- crop(cldmsk,e)
> stack16_cldmsk<- mask(test2, cldmsk_cropped, maskvalues = 100))
Errore: ')' inatteso in "stack16_cldmsk<- mask(test2, cldmsk_cropped, maskvalues = 100))"
> stack16_cldmsk<- mask(test2, cldmsk_cropped, maskvalues = 100)
> plot(stack16_cldmsk)
> im.plotRGB(stack16_cldmsk)
Errore in h(simpleError(msg, call)) : 
  errore durante la valutazione dell'argomento 'i' nella selezione di un metodo per la funzione '[[': argomento "r" assente, senza valore predefinito
> im.plotRGB(stack16_cldmsk,1,2,3)
> stack16_cldmsk<- mask(test2, cldmsk_cropped, maskvalues = 50)
> plot(stack16_cldmsk)
> stack16_cldmsk<- mask(test2, cldmsk_cropped, maskvalues = 200)
> plot(stack16_cldmsk)
> stack16_cldmsk<- mask(test2, cldmsk_cropped, maskvalues = 100)
> plot(stack16_cldmsk)
> b8_2016<- rast("T20NMK_20161130T143752_B8A_20m.jp2")
> stack16FC<- c(b8_2016,b4_2016,b3_2016)
Errore: [rast] extents do not match
> ext(b8_2016)
SpatExtent : 399960, 509760, 390240, 500040 (xmin, xmax, ymin, ymax)
> ext(b4_2016)
SpatExtent : -63.3181228616741, -63.131698606303, 3.58232958498001, 3.70139329487712 (xmin, xmax, ymin, ymax)
> ext(stack16)
SpatExtent : 399960, 509760, 390240, 500040 (xmin, xmax, ymin, ymax)
> plot(b8_2016
+ )
> Nir_crop<- (b8_2016, e)
Errore: ',' inatteso in "Nir_crop<- (b8_2016,"
> Nir_crop<- crop(b8_2016, e)
> plot(Nir_cropped)
Errore in h(simpleError(msg, call)) : 
  errore durante la valutazione dell'argomento 'x' nella selezione di un metodo per la funzione 'plot': oggetto 'Nir_cropped' non trovato
> plot(Nir_crop)

