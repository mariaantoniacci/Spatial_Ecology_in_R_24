# Multivariate analysis

# from a multisystem of band 1 and band 2 i obtain a pc1 of the st dev 

library(terra)
library(imageRy)
im.list()
sent <- im.import("sentinel.png")

# what is the correlation between all the bands?
pairs(sent)

# we can have everything together calculating PCA
sentpc <- im.pca(sent)

# analysis gives back 4 values of st. dev for each band (4 in total)
# we have variability for the pca components 
# sentpc has 3 principal component (one equals 0) 
# we want pc1 beacause of its higher variability or st. dev. (77)

# we also see on the matrix below correlations between original bands (sentinel 1,2,3,4)
# and the extracted components 

pc1 <- sentpc[[1]]

# calculate st. dev. ontop of PC1 
pc1stdev <- focal(pc1, matrix(1/9, 3,3), fun=sd)
plot(pc1stdev)
