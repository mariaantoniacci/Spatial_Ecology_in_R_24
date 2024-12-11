# Code to import external data

library(terra)

# download image from Nasa Earth Observatory, save it 

setwd("C://Users/anton/OneDrive/Documents/MAGISTRALE/SPATIAL ECOLOGY IN R")
getwd()

# in terra use function rast() to import data

scotland <- rast("scotland_outerhebrides_oli_20240918_lrg.jpg")
plotRGB(scotland, r=1, g=2, b=3)

# alternative for library terra
plot(scotland)


# Exercise: dowload a set of the Earth Observatoryand upload it in R
Patagonian_Shelf_Waters_Abloom <- rast("bloom_pace_20241130_lrg.jpg")
plot(Patagonian_Shelf_Waters_Abloom)
