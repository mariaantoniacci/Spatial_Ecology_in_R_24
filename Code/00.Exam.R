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

# CALCOLO DVI 2016
dvi2016= y2016FC[[1]] - y2016FC[[2]]
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)
plot(dvi2016, col=cl)

# CALCOLO DVI 2023
dvi2023= y2023FC[[1]] - y2023FC[[2]]
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)
plot(dvi2023, col=cl)

# CALCOLO NDVI 2016


