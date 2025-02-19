
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
# dopo aver fatto call con Diletta 
## GOLD MINING IN YANOMAMI REGION##

setwd("C:/SPATIAL ECOLOGY IN R")
library(terra)

> b2_16<- rast("T20NMK_20161130T143752_B02_20m.jp2") # blue
> b3_16<- rast("T20NMK_20161130T143752_B03_20m.jp2") # green 
> b4_16<- rast("T20NMK_20161130T143752_B04_20m.jp2") # red

#creo stack con le bande R G B
> stack16<- c(b4_16, b3_16, b2_16)

# plotto unendo insieme le bande 
> library(imageRy)
> im.plotRGB(stack16, 1,2,3)

# il plot mostra un'area molto più estesa di quella che serve a me con zoom su fiume 
# passaggi per fare un crop:
# 1. verifico l'extent della immagine intera
> ext(stack16)
# SpatExtent : 399960, 509760, 390240, 500040 (xmin, xmax, ymin, ymax)

# 2. verifico il sistema di riferimento
> crs(stack16)
# UTM zone 20N

# 3.Definisci l'extent con le coordinate geografiche dell'are di studio in coordinate geografiche (Lat/Long)
> e_wgs84 <- ext(-63.31080, -63.13003, 3.53774, 3.71831)

# 4. passaggi per fare un proiezione della zona di interesse (Copernicus mi da le coordinate geografiche non in metri)
# Definisci il CRS di origine (WGS 84)
> crs_wgs84 <- "EPSG:4326"  # Coordinate geografiche (Latitudine/Longitudine)
> # Definisci il CRS di destinazione (UTM zona 20N)
> crs_utm <- "EPSG:32620"  # UTM zona 20N
> 
> # Crea un oggetto raster per il calcolo della trasformazione
> raster_extent <- rast(nrows=1, ncols=1, ext=e_wgs84, crs=crs_wgs84)
> 
> # Converte l'extent in UTM zona 20N dell'area di interesse
> e_utm <- project(raster_extent, crs_utm)
> 
> # Estrai le nuove coordinate UTM dopo la trasformazione
> xmin_utm <- xmin(e_utm)
> xmax_utm <- xmax(e_utm)
> ymin_utm <- ymin(e_utm)
> ymax_utm <- ymax(e_utm)

xmin = 465481  
xmax = 485498.4 
ymin = 390979.4  
ymax = 410996.8 

# creao oggetto con nuovo extent in UTM che è quello che mi permette di ritagliare dall'immagine grande l'area di interesse
> e<- ext(465481,485498.4,390979.4,410996.8)

# test2= immagine di Sentinel" ritagliata 
> test2<- crop(stack16,e)
# stack16 è stata ritagliata 
# plotto le bande RGB di stack16 ritagliata=test2
> im.plotRGB(test2,1,2,3)

# Importo la mask per le nuvole 
> cldmsk<- rast("MSK_CLDPRB_20m.jp2")
# taglio la maschera che ha l'extent originale troppo grande
# utilizzo lo stesso extent dell'immagine che voglio 
> cldmsk_cropped<- crop(cldmsk,e)

# applico la maschera su test2 selezioanndo maskvalues=100 (nuovole piene)
stack16_cldmsk<- mask(test2, cldmsk_cropped, maskvalues = 100)
# plotto
 plot(stack16_cldmsk)
 im.plotRGB(stack16_cldmsk,1,2,3)

# ottengo la foto in TC con la maschera sopra dove i pixel delle nuvole=NA

# Voglio l'immagine in FALSE color 
# nel file scaricato NON c'è la banda NIR 
# pROVO CON LA BANDA 8A MA NON è LA STESSA COSA

# importo la banda 8A del NIR
> b8_2016<- rast("T20NMK_20161130T143752_B8A_20m.jp2")
# check dell'extent della banda 8A
> ext(b8_2016)
SpatExtent : 399960, 509760, 390240, 500040 (xmin, xmax, ymin, ymax)
# è la stessa della immagine grande originale 
> ext(stack16)
SpatExtent : 399960, 509760, 390240, 500040 (xmin, xmax, ymin, ymax)
# lo verifico anche plottando la banda 
> plot(b8_2016)
# taglio con crop la porzione che mi interessa utilizzando le coordinate UTM di prima (e)
> nir<- crop(b8_2016, e)
# check per vedere se ha funzionato
> plot(Nir_crop)


# ALTRA MODALITà
# UTILIZZO RIQUADRO di selezione area SU COPERNICUS E SCARICO BANDE SINGOLE 
b4_1<- rast("b4_test.tiff")
b3_1<- rast("b3_test.tiff")
b2_1<- rast("b2_test.tiff")
stack2<- c(b4_1,b3_1, b2_1)
TC_test<-im.plotRGB(stack2, 1,2,3)
# funziona

# PROVO AD APPLICARCI LA MASK
# per farlo devo prima verificare ext di stack2
ext(stack2)
# SpatExtent : -63.310844, -63.130051, 3.537684, 3.718192 (xmin, xmax, ymin, ymax)
e_wgs84 <- ext(-63.310844, -63.130051, 3.537684, 3.718192)
# passaggi per fare un proiezione della zona di interesse (Copernicus mi da le coordinate geografiche non in metri)
# Definisci il CRS di origine (WGS 84)
crs_wgs84 <- "EPSG:4326"  # Coordinate geografiche (Latitudine/Longitudine)
# Definisci il CRS di destinazione (UTM zona 20N)
crs_utm <- "EPSG:32620"  # UTM zona 20N
# Crea un oggetto raster per il calcolo della trasformazione
raster_extent1 <- rast(nrows=1, ncols=1, ext=e_wgs84, crs=crs_wgs84)
# Converte l'extent in UTM zona 20N dell'area di interesse
stack2_utm <- project(raster_extent1, crs_utm)
ext(stack2_utm)
# SpatExtent : 465476.148256286, 485491.422659762, 390968.519132133, 410983.793535609 (xmin, xmax, ymin, ymax)
# queste le coordinate giuste in UTM 
# che dovrà avere anche la cloud mask 
# creo vettore con queste estensioni per utilizzarlo nel crop
n_e <- ext(465476.148256286, 485491.422659762, 390968.519132133, 410983.793535609)
cloudmask<- crop(cldmsk,n_e)

# non funziona, mi arrendo 



# TENTATIVO CON RISOLUZIONE A 10m
setwd("C:/SPATIAL ECOLOGY IN R")
library(terra)
b2_16<- rast("T20NMK_20161130T143752_B02_10m.jp2") # blue
b3_16<- rast("T20NMK_20161130T143752_B03_10m.jp2") # green 
b4_16<- rast("T20NMK_20161130T143752_B04_10m.jp2") # red
stack<- c(b4_16, b3_16, b2_16)
library(imageRy)
im.plotRGB(stack,1,2,3)
ext(stack)
#IMPOSTO L'ESTENSIONE CHE MI SERVE
e<- ext(465481,485498.4,390979.4,410996.8)
im.plotRGB(stack_crop,1,2,3)
cldmsk<- rast("MSK_CLDPRB_20m.jp2")

# UTILIZZARE FUNZIONE DISAGGREGATE perchè la mask è risoluzione 20m ma le bande a 10m
# Aumenta la risoluzione del raster da 20m a 10m
# In questo caso, vogliamo duplicare la risoluzione, quindi dobbiamo impostare il fattore di disaggregazione a 2
# fact = 2: Poiché la risoluzione di partenza è 20m e desideri una risoluzione di 10m, il fattore di disaggregazione deve essere 2 (perché 20m / 10m = 2). Questo significa che ogni pixel originale verrà suddiviso in un 2x2 quadrato di nuovi pixel, con la risoluzione dimezzata.
# Interpolazione: Quando aumenti la risoluzione con disagg(), R genera nuovi valori per i pixel creati (questo dipende dal tipo di interpolazione applicata). Per impostazione predefinita, disagg() usa l'interpolazione bilineare, che può essere modificata se necessario.
cldmsk_10m <- disagg(cldmsk, fact = 2)
                                          
plot(cldmsk_10m)
cldmsk_10m_crop<- crop(cldmsk_10m,e)
plot(cldmsk_10m_crop)
# verifico che l'ext sia lo stesso per applicare maschera
ext(cldmsk_10m_crop)
# SpatExtent : 465480, 485500, 390980, 411000 (xmin, xmax, ymin, ymax)
ext(stack_crop)
# SpatExtent : 465480, 485500, 390980, 411000 (xmin, xmax, ymin, ymax)
# 100= nuvole piene 
stack_crop_msk<- mask(stack_crop, cldmsk_10m_crop, maskvalues = 100)
# plotto
plot(stack_crop_msk)
im.plotRGB(stack_crop_msk,1,2,3)
stack_crop<- crop(stack,e)

# voglio l'immagine in FC
# importo banda8
b8_16<- rast("T20NMK_20161130T143752_B08_10m.jp2") # nir
stackFC<- c(b8_16, b4_16, b3_16)
im.plotRGB(stackFC,1,2,3)
# taglio immagine
e<- ext(465481,485498.4,390979.4,410996.8)
stackFC_crop<- crop(stackFC,e)
stackFC_crop_msk<- mask(stackFC_crop, cldmsk_10m_crop, maskvalues = 100)

# 1= NIR
# 2= red
# 3= green
im.plotRGB(stackFC_crop_msk,1,2,3)

# NIR on blue
im.plotRGB(stackFC_crop_msk,3,2,1)

# calcolo DVI
dvi2016= stackFC_crop_msk[[1]] - stackFC_crop_msk[[2]]
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)
plot(dvi2016, col=cl)

# calcolo NDVI
ndvi2016 = dvi2016 / (stackFC_crop_msk[[1]]+stackFC_crop_msk[[2]])
plot(ndvi2016)

# classifico 
# 3 classi per foresta, miniere, acqua
im.classify(ndvi2016, num_clusters=3)
