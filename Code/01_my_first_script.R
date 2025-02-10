# there are 3 concepts:
# 1. object
# 2. the assignemnt (<-)
# 3. comment (like this one!)
# 4. functions (like function 'c()' and 'plot()' containing different arguments
# 5. arrays (set of different elements)

2 + 3 # this is my first operation in R 

# it's important to make use of objects
cato <- 2 + 3 #the result of the operation is assigned to an object called 'cato'


maria <- 4 + 2
maria 

cato + maria

cato ^ maria

(cato + maria) ^ cato 


# arrays or vectors
andrea <- c(10, 15, 20, 50, 70) # concatenated objects in a function 
# all arguments are separted by commas in a function
andrea

sofia <- c(100, 200, 300, 400, 500)

# now i want to correlate andrea and sofia, eg. reationship between amount of co2 and the fruits 
# i use function 'plot'

plot(sofia, andrea)

# i can change stuff in the plot
# symbols, as black filled circles
# pch R software: each number associated with a symbol 
# check the site https://www.datanovia.com/en/blog/pch-in-r-best-tips/

plot(sofia, andrea, pch=19) # sofia here is an argument but no space between parenthesis 

plot(sofia, andrea, pch=19, cex=2) # cex to modify dimension of points bigger 

plot(sofia, andrea, pch=19, cex=0.5) # to modify dimension of points 0.5 or smaller

plot(sofia, andrea, pch=19, cex=2, col="blue") # col to modify color in https://r-graph-gallery.com/42-colors-names.html

plot(sofia, andrea, pch=19, cex=2, col="blue", xlab="C02", ylab="amount of fruits") # to modify labels 
