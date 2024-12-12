# from a multisystem of band 1 and band 2 i obtain a single axis pc1 of the st dev 

library(terra)
library(imageRy)
im.list()
sent <- im.import("sentinel.png")

# whtas the correlation of all the bands
pairs(sent)

# we can have everything together
sentpc <- im.pca(sent)

# we have variability for the pca components 
# pc1 is the first principal component 
# pc1 in general has the higher variability 82

# sentpc has 3 principal component buit we want pc1

pc1 <- sentpc[[1]]

pc1stdev <- focal(pc1, matrix(1/9, 3,3), fun=sd)

# pc1 map to use variability 
