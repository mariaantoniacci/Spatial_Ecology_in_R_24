# Classification in R using imageRy

# correlation between a pixel and its reflectance in different bands in a graph x,y
# example: 3 pixels are stricly related to each other beacause of their similar reflectance 
# additionally, the distance between 3 pixels belonging to the same class is shorter than the distance from another band 

# this is called classification of landcover classes

# once the classification is done
# calculate how many pixels belong to those classes (which are objects where the pixels are taken from) 
# example "mato grosso" images: how many pixels representing forest cover in 1992? 
# how many in 2006?

# libraries we need:

library(terra)
library(imageRy)
library(ggplot2)
im.list() 

# from the dataset select Solar Orbiter 

sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

# we can detect at least 3 classes, high energy, low energy and medium energy

im.classify(sun, num_clusters=3) 

# specify how many clusters or classes we want by "num_clusters="
# depending on the point from which algorithm starts the operation, that would be the first class (ex. medium energy)

# do the same on Mato grosso to see changes in terms of cover % of forest in 1992 and 2006

m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

# 2 clusters represent forest and not forest
m1992c <- im.classify(m1992,num_clusters=2) 

# in my case for 1992:
# class 1 = human releted areas + water 
# class 2 = forest

m2006c <- im.classify(m2006,num_clusters=2) 

# in my case for 2006:
# class 1 = forest
# class 2 = human related areas + water 

# now calculate the frequency (or amount) of pixels contained inside the classes
f1992 <- freq(m1992c)
# since it's better to think in % rather than frequencies, let's calculate %
# total of pixels in m1992c
tot1992 <- ncell(m1992c)
p1992 = f1992*100/tot1992

# class 1 = human related areas + water = 17% cover
# class 2= forest = 83% cover

# same for 2006:

f2006 <- freq(m2006c)
tot2006 <- ncell(m2006c)
p2006 = f2006*100/tot2006

# class 1= forest = 45%
# class 2 = human related areas + water = 55%

# build a dataframe with 3 columns to be clumped together
class <- c("Forest", "Human related areas")
y1992 <- c(83, 17)
y2006 <- c(45, 55)

tabout <- data.frame(class, y1992, y2006) 
tabout

# library (ggplot2) is needed for the final graph
library(ggplot2)

# first argument of the function is the data frame we want to plot
# aestetics (aes) = what is axis x (class), what is y (y1992) and colour 
# then we state which type of graph we want using + and geom_bar() function
# inside geom_bar, stat="identity" means it takes the exact value
# while fill="" to fill it with a specified colour 

#1992
ggplot (tabout, aes(x=class, y=y1992, color=class))+ geom_bar(stat="identity", fill="white")
#2006
ggplot (tabout, aes(x=class, y=y2006, color=class))+ geom_bar(stat="identity", fill="white")

# it's a quantitative graph!

# to glue graphs together in a single one
# we need "patchwork" package 
install.packages("patchwork")
library(patchwork)

# assign each graph to an object
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")
p1 + p2

# there's a graphical error to change values in the y axis
# so we add another element to the array to limit y values in the range 0 to 100 
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2

# to have one plot on top the other 
p1/p2
