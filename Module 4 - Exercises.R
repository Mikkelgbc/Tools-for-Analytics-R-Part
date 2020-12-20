# Module 4


# 4.6.1 Exercise (conditional expressions)
# Solve this exercise using a script file

# Task 1: Consider object x: What will this conditional expression return?
x <- c(1,2,-3,4)

if(all(x > 0)){
  print("All Positives")
} else {
  print("Not all positives")
}
# Answer: "Not all positives" as c3 is negative.



# Task 2: What will the following expressions return?
x <- c(TRUE,FALSE,TRUE,TRUE)
all(x) #Answer: False
any(x) #Answer: True
any(!x) #Answer: True
all(!x) #Answer: False



# Task 3: Which of the expressions above is always FALSE when at least one entry of a logical vector x is TRUE?
# Answer: any(x)

# Consider
library(tidyverse)
x <- 1:15
x



# Task 4: Use the if_else function to set elements with value below 7 to 0
if_else(x < 7, as.integer(0),x) # If x is less than 7, assign 0, otherwise assign x



# Task 5: Use the if_else function to set elements with value below 7 or above 10 to NA_integer_ (which is the NA/missing value of an integer).
if_else(x < 7|x > 10, as.integer(NA_integer_),x) # If x is less than 7, or greater than 10 assign NA, otherwise assign x
x



# Task 6: Consider code
x <- sample(c(1:10,NA,5.5),1)
x

# Write code which set object y equal to “even” if x is even, “odd” if x is odd, “decimal” if x has a decimal not zero and “missing” if x is NA. 
# Hint: have a look at ?'%%' (the modulo operator).
x <- sample(c(1:10,NA,5.5),1)
if(is.na(x)){
  y <- "missing"
} else if (x %% 2 == 0){
  y <- "even"
} else if (x %% 2 == 1){
  y <- "odd"
} else if (x %% 1 > 0){
  y <- "decimal"
}
x
y


# 4.6.2 Exercise (loops)

# Task 1: Using a for loop, create a vector having values 2i + 4 given i=1 … 4
x <- rep(NA,4) # Creates an empty vector of 4 values

for(i in 1:4){ #Loops trough i=1 to 4 and assigns the value to x[i]
  x[i] <- 2*i+4
}

x



# Task 2:Using a for loop, create a vector having values 2i + 4 given i=2,5,6,12
iVal <- c(2, 5, 6, 12) # Defines the values of i
x <- rep(NA,length(iVal)) # Creates an empty vector with the length og iVal
x

for (idx in 1: length(iVal)){
  x[idx] <- 2*iVal[idx]+4
}



# Task 3: Solve Question 2 using a while loop
iVal <- c(2, 5, 6, 12) # Defines the values of i
x <- rep(NA,length(iVal)) # Creates an empty vector with the length and iVal
idx <- 1 # Used to count number of iterations
while(idx < 5){ # Loop while the number of iterations is less than 5 (=4)
  x[idx] <- 2*iVal[idx]+4
  idx <- idx + 1
}
x



# Task 4: Solve Questions 1 and 2 using a vectorized alternative
2*1:4+4 #Q1

2*c(2,5,6,12)+4 #Q2



# 4.6.3 Exercise (calculating distances)
## Consider zip codes in Jutland:

### Load packages
library(tidyverse)
library(tfa) # the course package devtools::install_github("bss-osca/tfa/tfa-package")

### Read data
zips

### We want to calculate distances between a subset of zip areas (from 1 to 5):
idx <- 1:5
dat <- zips[idx,]
dat

### We make an empty matrix (5x5)
distanceMat <- matrix(NA, nrow = length(idx), ncol = length(idx))

### We assign names to column and rows
colnames(distanceMat) <- str_c(dat$Zip[idx], dat$Area[idx], sep = " ") 
rownames(distanceMat) <- colnames(distanceMat)

### Check matrix
distanceMat


## We can find average distances between two zip codes (here rows 1 and 2 in dat) using Bing maps:

### We collect data from bing
key <- "AlUJdApmvPe8y2_IMrC4j4x8fzytbD2M0SvlmpemL09ae_CWS6-IuNSgrAtXoyeP"
url <- str_c("http://dev.virtualearth.net/REST/V1/Routes/Driving?wp.0=",
             dat$Zip[1], ",Denmark",
             "&wp.1=",
             dat$Zip[2], ",Denmark",
             "&avoid=minimizeTolls&key=", key)

### Read packages
library(jsonlite)

### We make a list from our data file
lst <- jsonlite::fromJSON(url)

### We read the travel distance from the list
dist <- lst$resourceSets$resources[[1]]$travelDistance

### We check the result
dist

### We read the status code from the list
lst$statusCode

### We read the status description from the list
lst$statusDescription


## Use nested for loops to fill distanceMat with distances. Assume that the distance from a to b is the same as from b to a. 
## That is, you only have to call the API once for two zip codes. Use an if statement to check if the status code is okay

### Assign key
key <- "AlUJdApmvPe8y2_IMrC4j4x8fzytbD2M0SvlmpemL09ae_CWS6-IuNSgrAtXoyeP"


### Nested for loop calculating distance

#### For each row...
for(i in 1:nrow(distanceMat)) {
  
  #### and each column
  for(j in 1:ncol(distanceMat)) {
    
    #### If i is greater than j, then distance assume symmetric distances
    if (i>j) {distanceMat[i,j] <- distanceMat[j,i]; next}
    
    #### If value in matrix is different from NA, then skip (Value alredy calculated)
    if (!is.na(distanceMat[i,j])) next
    
    #### If i equals j then distance is equal to 0
    if (i==j) {distanceMat[i,j] <- 0; next}
    
    #### Collect data from Bing
    url <- str_c("http://dev.virtualearth.net/REST/V1/Routes/Driving?wp.0=",
                 dat$Zip[i], ",Denmark",
                 "&wp.1=",
                 dat$Zip[j], ",Denmark",
                 "&avoid=minimizeTolls&key=", key)
    
    #### Store data in a list
    lst <- jsonlite::fromJSON(url)
    
    #### If the status code is 200...
    if (lst$statusCode == 200) {
      
      #### Then fill the distance matrix with the travel distances from the data
      distanceMat[i,j] <- lst$resourceSets$resources[[1]]$travelDistance
    }
  }
}


### Show distance matrix
distanceMat



# 4.6.4 Exercise (expand_grid)
## Consider the solution of Exercise 4.6.3 and assume that you only want to calculate the distance from rows 1 and 5 to rows 2 and 3 in dat.
## Modify the solution using expand_grid so only one loop is used.

### Use expand grid to calculate the distance from rows 1 and 5 to row 2 and 3.
ite <- expand_grid(i = c(1,5), j = 2:3)

### Show grid
ite

### Assign key
key <- "AlUJdApmvPe8y2_IMrC4j4x8fzytbD2M0SvlmpemL09ae_CWS6-IuNSgrAtXoyeP"

### Loop calculating distances

#### iterate over rows
for (r in 1:nrow(ite)){
  
  #### Assign i and j to the respective column in grid
  i <- ite$i[r]
  j <- ite$j[r]
  
  #### If i is equal j, then distance is equal to 0
  if (i==j) {distanceMat[i,j] <- 0; next}
  
  #### Collect data from Bing
  url <- str_c("http://dev.virtualearth.net/REST/V1/Routes/Driving?wp.0=",
               dat$Zip[i], ",Denmark",
               "&wp.1=",
               dat$Zip[j], ",Denmark",
               "&avoid=minimizeTolls&key=", key)
  
  #### Store data in a list
  lst <- jsonlite::fromJSON(url)
  
  #### If status code is 200...
  if (lst$statusCode == 200) {
    
    #### Then fill distance matrix with the travel distances from the data
    distanceMat[i,j] <- lst$resourceSets$resources[[1]]$travelDistance
    
    #### Assume symmetric distances
    distanceMat[j,i] <- distanceMat[i,j]
  }
}

distanceMat

