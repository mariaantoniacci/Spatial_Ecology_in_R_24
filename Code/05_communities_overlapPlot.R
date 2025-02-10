# Relation among species in time
# code to estimate the temporal overlap between species

install.packages("overlap")

library(overlap)

# use some data called kerinci
data(kerinci)

# exercise: show first 6 rows of kerinci and check the name of columns
head(kerinci)
names(kerinci)

# to see the dataset per se
kerinci

# summary gives an idea about the statistics of field
summary(kerinci)
# gives same individual in different times records, min and max

# time is linear dimension but we want the circular dimension as radiance multiplying 2pigreco

kerinci$Time * 2 * pi 

# suggested to create a new column and link it to the group kerinci

kerinci$Timecirc <- kerinci$Time * 2 * pi

# to check the new column
head(kerinci)

# take a new obj tiger and we assign to that only the new dataset with just data for tiger

tiger <- kerinci[kerinci$Sps=="tiger",]

# the , to end the query
# query is developed in sql as == (equal) while != (not equal)

# we plot a density plot using time from tiger data

# select only tiger timecirc
tigertime <- tiger$Timecirc

densityPlot(tigertime)

# peak at 6am to search for food, the same in the evening searchin for repair for the night 

# let's do the same for another species and overlap

# Exercise: select in a new obj the data macaque and assign them to a new obj 

macaque <- kerinci[kerinci$Sps=="macaque",]

# then select the time for the macaque data
macaquetime <- macaque$Timecirc

densityPlot(macaquetime)

# how 2 sps are related in time 
# we speak about spatial temporal eco

overlapPlot(tigertime, macaquetime)


# --------------SQL revise 

macaque <- kerinci[kerinci$Sps=="macaque",]
nomacaque <- kerinci[kerinci$Sps!="macaque",] 

# to esclude the macaque from the dataset 
summary(nomacaque)
