# correlate a pixel to its reflectance on the graph in different bands.
# three pixel and state maybe these pixels are stricly related to each other beacuase similar reflectance.
# or the distance of a pixel is shorten than the distace from another band 
# this is called classification of landcover classes 
# then i can calculate how many pixels are in the classes (obj where the pixels are taken from) 
# example: mato grosso how many pixel there were representing forest? how many now?
# classification type called: 

_ Classification in R using imageRy

library(terra)
library(imageRy)
library(ggplot2)
im.list() # select Solar Orbiter to classufy

im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

# we can detect at least 3 classes, high energy, low energy and medium energy

im.classufy(sun, num_clusters=3) # specify how many clusters or classses we want

# depending on the point in which algorith daoes the operation, taht would be the first class, ex. medium energy

# do the sam eon Mato grosso to see changes in terms of % of forest

m1992<-im.import("matogrosso_l5_1992219_lrg.jpg")
m2006<-im.import("matogrosso_ast_2006209_lrg.jpg")

m1992c<- im.classify(m1992,num_clusters=2) # forest and not forest

# in my case:
# class 1 = human releted areas + water 
# class 2 = forest

 m2006c<- im.classify(m2006,num_clusters=2) 

# more difficult to compared now but in my case:
# class 1 = forest
# class 2 = human related areas + water 

# now calculated the frequency (or amount) of pixels cointained to that class

f1992<- freq(m1992c)

# since it's better to think in % we calculate the percentages

# total o pixels in m1992c
tot1992 <- ncell(m1992c)

p1992 = f1992*100/tot1992

# class 1 = human related areas + water = 16
# class 2= forest = 83

f2006 <- freq(m2006c)
tot2006 <- ncell(m2006c)
p2006 = f2006*100/tot2006

# class 2 = human related areas + water = 55
# class 1= forest = 45

# dataframe in 3 colums to be clumped together
class <- c("Forest", "Human")
y1992 <- c(83, 17)
y2006 <- c(45, 55)

tabout <- data.frame(class, y1992, y2006) 
tabout

# we need the library (ggplot2) for the final graph

# measure funtion is:
ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white")

# aesthetics is aes() needed to get histogramm like graph
# now we add to the ggplot() as par()
# it's a quantitative graph

ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")

# to glue together the graphs in a single graph
# we need to
install.packages("patchwork")
library(patchwork)

# assign each graph to an object
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")
p1 + p2


# there's a graphical error to change values in th ey axis
# so we add anpther element to the array to limit 0 to 100 
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2
# to have one plot on top the other 
p1/p2



# images, spectral qualities, temporal changes, classify and have a quantitative information 
