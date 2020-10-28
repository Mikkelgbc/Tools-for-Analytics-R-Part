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
x <- rep(NA,length(iVal)) # Creates an empty vector with the lenght og iVal
x

for (idx in 1: length(iVal)){
  x[idx] <- 2*iVal[idx]+4
}


# Task 3: Solve Question 2 using a while loop
iVal <- c(2, 5, 6, 12) # Defines the values of i
x <- rep(NA,length(iVal)) # Creates an empty vector with the length og iVal
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
# Consider zip codes in Jutland:
library(tidyverse)
library(tfa) # the course package devtools::install_github("bss-osca/tfa/tfa-package")
zips

# We want to calculate distances between a subset of zip areas:
idx <- 1:5
dat <- zips[idx,]
dat

distanceMat <- matrix(NA, nrow = length(idx), ncol = length(idx))
colnames(distanceMat) <- str_c(dat$Zip[idx], dat$Area[idx], sep = " ") 
rownames(distanceMat) <- colnames(distanceMat)
distanceMat


# We can find average distances between two zip codes (here rows 1 and 2 in dat) using Bing maps:
key <- "AlUJdApmvPe8y2_IMrC4j4x8fzytbD2M0SvlmpemL09ae_CWS6-IuNSgrAtXoyeP"
url <- str_c("http://dev.virtualearth.net/REST/V1/Routes/Driving?wp.0=",
             dat$Zip[1], ",Denmark",
             "&wp.1=",
             dat$Zip[2], ",Denmark",
             "&avoid=minimizeTolls&key=", key)
library(jsonlite)
lst <- jsonlite::fromJSON(url)
dist <- lst$resourceSets$resources[[1]]$travelDistance
dist

lst$statusCode

lst$statusDescription


# Use nested for loops to fill distanceMat with distances. Assume that the distance from a to b is the same as from b to a. 
# That is, you only have to call the API once for two zip codes. Use an if statement to check if the status code is okay

key <- "AlUJdApmvPe8y2_IMrC4j4x8fzytbD2M0SvlmpemL09ae_CWS6-IuNSgrAtXoyeP"

for(i in 1:nrow(distanceMat)) {
  for(j in 1:ncol(distanceMat)) {
    if (i>j) {distanceMat[i,j] <- distanceMat[j,i]; next}   # assume symmetric distances
    if (!is.na(distanceMat[i,j])) next   # value already calculated 
    if (i==j) {distanceMat[i,j] <- 0; next}
    
    url <- str_c("http://dev.virtualearth.net/REST/V1/Routes/Driving?wp.0=",
                 dat$Zip[i], ",Denmark",
                 "&wp.1=",
                 dat$Zip[j], ",Denmark",
                 "&avoid=minimizeTolls&key=", key)
    lst <- jsonlite::fromJSON(url)
    if (lst$statusCode == 200) {
      distanceMat[i,j] <- lst$resourceSets$resources[[1]]$travelDistance
    }
  }
}

distanceMat


# 4.6.4 Exercise (expand_grid)
# Consider the solution of Exercise 4.6.3 and assume that you only want to calculate the distance from rows 1 and 5 to rows 2 and 3 in dat.
# Modify the solution using expand_grid so only one loop is used.

ite <- expand_grid(i = c(1,5), j = 2:3)
ite
key <- "AlUJdApmvPe8y2_IMrC4j4x8fzytbD2M0SvlmpemL09ae_CWS6-IuNSgrAtXoyeP"
for (r in 1:nrow(ite)) { # iterate over rows
  i <- ite$i[r]
  j <- ite$j[r]
  if (i==j) {distanceMat[i,j] <- 0; next}
  url <- str_c("http://dev.virtualearth.net/REST/V1/Routes/Driving?wp.0=",
               dat$Zip[i], ",Denmark",
               "&wp.1=",
               dat$Zip[j], ",Denmark",
               "&avoid=minimizeTolls&key=", key)
  lst <- jsonlite::fromJSON(url)
  if (lst$statusCode == 200) {
    distanceMat[i,j] <- lst$resourceSets$resources[[1]]$travelDistance
    distanceMat[j,i] <- distanceMat[i,j]
  }
}
distanceMat

