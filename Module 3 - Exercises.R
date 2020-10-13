# 3.10.1 Exercise (group work)

# Before you start, it is a good idea to agree on a set of group rules:

#   Create a shared folder and project for your group.
#   Agree on a coding convention.
#   Agree about the rules of how to meet etc.


# 3.10.2 Exercise (install packages)
#   1. Install the package devtools
#   2. Have a look at the documentation for function install_github
#   3. Install the package tfa


# 3.10.3 Exercise (piping)

#Intro
head(mtcars)
?mtcars

library(tidyverse)
mtcars %>% select(cyl,gear,hp,mpg) %>% filter(gear == 4 & cyl == 4)

# Task 1
mtcars %>% select(mpg,hp,gear,am,gear)

# Task 2
mtcars %>% select(mpg,hp,gear,am,gear) %>% filter(mpg < 20 & gear == 4)

# Task 3
mtcars %>% select(mpg,hp,gear,am,gear) %>% filter(mpg < 20 | gear == 4)

# Task 4
mtcars %>% filter(mpg < 20 & gear == 4) %>% select(wt,vs)

# Task 5
dat <- mtcars
dat <- filter(dat,mpg < 20 & gear == 4)
dat <- select(dat,wt,vs)
dat


#3.10.4 Exercise (working dir)

#Do from console
# Intro
dir.create("subfolder", showWarnings = FALSE) 
write_file("Some text in a file", path = "test1.txt")
write_file("Some other text in a file", path = "subfolder/test2.txt")

# Taksk 1
read_file("test1.txt")

# Task 2
read_file("subfolder/test2.txt")

# Task 3 & 4
setwd("subfolder")  # done in Q3
read_file("../test1.txt")
read_file("test2.txt")


# 3.10.5 Exercise (vectors)

#Task 1
n <- 100
n * (n+1)/2

# Alternative solution:
n <- 100
v <- c(1:100)
sum(v)

# Task 2
n <- 1000
n * (n+1)/2

# Task 3
n <- 1000
x <- seq(1, n)
sum(x)
# Answer: b)

# Task 4
set.seed(123)
v <- sample.int(100,30)
v
# Answer: It makes 30 numbers between 1 and 100

# Task 5
sum(v)
mean(v)
sd(v)

# Task 6
v[c(1,6,4,15)]

# Task 7
v[v>50]

# Task 8
v[v > 75 | v < 25]

# Task 9
v[v == 43]

# Task 10
v[is.na(v)]

# Task 11
which(v > 75| v < 25)


# 3.10.6 Exercise (matrices)

