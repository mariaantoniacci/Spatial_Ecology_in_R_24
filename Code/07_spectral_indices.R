# Spectral indices

library(imageRy)
library(terra)

im.list()

# Import data: directly a stack of different data, bands with "matogrosso_ast_2006209_lrg.jpg"
im.import("matogrosso_ast_2006209_lrg.jpg")

m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

# to see data digit 
m2006

# from NASA "matogrosso_ast_2006209_lrg.jpg" it is stated that:
# band 1 = NIR
# band 2 = red
# band 3 = green

# use them for RGB image

im.plotRGB(m2006, r=1, g=2, b=3)

# we can plot single band: 2 and 3 don't make much difference. To test:
plot(m2006[[2]])
plot(m2006[[3]])

# bare soil if NIR on top on the blue band becomes yellowish
im.plotRGB(m2006, r=3, g=2, b=1)

# bare soil is pink if on top of green band
im.plotRGB(m2006, r=3, g=1, b=2)

# import image from 1992 to see state of art before human intervention
m1992<- im.import("matogrosso_l5_1992219_lrg.jpg") 
im.plotRGB(m1992, r=1, g=2, b=3)

# Multiframe
par(mfrow=c(1,2))
im.plotRGB(m1992, r=1, g=2, b=3)
im.plotRGB(m2006, r=1, g=2, b=3)

