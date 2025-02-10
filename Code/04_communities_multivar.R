# community level

# code for multivariate analysis of species x plot data in communities

# install package vegan from CRAN  

install.packages("vegan")
library(vegan)

data(dune)

dune 
# i obtain the matrix 

head(dune) # first 6 lines restricted for each sample 6 plots 

View(dune) # to see back the whole table; remember capital letter V

# in the package vegan the analysis is fast and simple with function decorana of the dataset dune: 
# from help: Performs detrended correspondence analysis and basic reciprocal averaging or orthogonal correspondence analysis.
# it is a detrended corresposndace analysis and basic reciprocal avaraging
# useful when the range is quite spread out and wide, it compacts mathemathically the data reducimg dimensions and widespread of data

# Analysis
decorana(dune)
multivar <- decorana(dune) 
# the original set is compressedd to 4 axis 
# writing decorana(dune) we obtain 4 axes (DCA1,2,3,4) 

dca1 = 3.7004

# each DCA is the length of axis representing the whle dataset
# the length is the amount of range represented by the axis. 
# the aim is to see the percentage of the original range which is incorporated in 2 axes. 
# the maximum amount of axis we can use is 3 because our brains work in 3 dimensions.

# 4 axes of lenghts x (amount of range represented by the first axis)
# calculate the percentage of each axis compared to the all dataset
# what's the % of the original is represented by the component 1?

dca1 = 3.7004
dca2 = 3.1166
dca3 = 1.30055
dca4 =  1.47888

total = dca1 + dca2 + dca3 + dca4 

# dca1 lenght divided by the total times 100 to get the %

# Proportions 
prop1 = dca1/total
prop2 = dca2/total
prop3 = dca3/total
prop4 = dca4/total

# Percetanges
perc1 = prop1*100
perc2 = prop2*100
perc3 = prop3*100
perc4 = prop4*100

# from original table matrix to a 2 dimension graph

# Whole amouont of variability in %
perc1 + perc2

# instead of using 20 diffrent plots i compact dataset to a final set of two axes 
# loss is 29% of the original information but it does worth it 

# the first two axes explain 71% of the variability 

plot(multivar)

# now i can see which species are more correlated 
