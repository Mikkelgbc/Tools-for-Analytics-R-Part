# Module 3


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
mtcars %>% 
  select(cyl,gear,hp,mpg) %>%
  filter(gear == 4 & cyl == 4)

# Task 1
mtcars %>% 
  select(mpg,hp,gear,am,gear)

# Task 2
mtcars %>% 
  select(mpg,hp,gear,am,gear) %>% 
  filter(mpg < 20 & gear == 4)

# Task 3
mtcars %>% 
  select(mpg,hp,gear,am,gear) %>% 
  filter(mpg < 20 | gear == 4)

# Task 4
mtcars %>% 
  filter(mpg < 20 & gear == 4) %>%
  select(wt,vs)

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

#Intro
m1 <- matrix(c(37, 8, 51, NA, 50, 97, 86, NA, 84, 46, 17, 62L), nrow = 3)
m1
m2 <- matrix(c(37, 8, 51, NA, 50, 97, 86, NA, 84, 46, 17, 62L), nrow = 3, byrow = TRUE)
m2
m3 <- matrix(c(37, 8, 51, NA, 50, 97, 86, NA, 84, 46, 17, 62L), ncol = 3)
m3

# Task 1
# Question: What is the difference between the three matrices?
# Answer: m1 has 3 rows filling one column at a time, m2 has 3 row filling one row at a time and m3 has 3 columns filling one column at a time

# Task 2
rowSums(m1,na.rm=TRUE)
colSums(m2,na.rm = TRUE)

# Task 3
rbind(m1,c(1,2,3,4))

# Task 4
rbind(c(1,2,3,4),m1)

# Task 5
cbind(m3,c(1,2,3,4))

# Task 6
m1[2,4]

# Task 7
m1[2:3,1:2]

# Task 8
m1[3, c(1,3,4)]

# Task 9
m1[3,]

# Task 10
m2[is.na(m2)]

# Task 11
m2[m2 > 50]


# 3.10.7 Exercise (data frames)

# Intro
str(mtcars)
glimpse(mtcars)
?mtcars

# Task 1
head(mtcars)
tail(mtcars)

# Task 2
mtcars[,4]
mtcars[,"hp"]
mtcars$hp

# Task 3
data(mtcars) #Resets data

mtcars <- rbind(mtcars,c(34, 3, 87, 112, 4.5, 1.515, 167, 1, 1, 5, 3))
rownames(mtcars)[33] <- "Phantom XE"

# Task 4
col <- c(NA, "green", "blue", "red", NA, "blue", "green", "blue", "red", "red", "blue", "green", "blue", "blue", "green", "red", "red", NA, NA, "red", "green", "red", "red", NA, "green", NA, "blue", "green", "green","red", "green", "blue", NA)
mtcars <- cbind(mtcars,col)
class(mtcars$col)

# Task 5
mtcars[mtcars$vs==0,]


# 3.10.8 Exercise (lists)

# Intro
lst <- list(45, "Lars", TRUE, 80.5)
lst

x <- lst[2]
x

y <- lst[[2]]
y

# Task 1

# What is the class of the two objects x and y? 
# Answer:
class(x) # List
class(y) # character

# What is the difference between using one or two brackets?
# Answer: One corresponds to the list, while two corresponds to the character (same result)

# Task 2
names(lst) <- c("age","Name","Male?","Weight")
lst

# Task 3
lst$Name

#Text
lst$height <- 173  # add component
lst$name <- list(first = "Lars", last = "Nielsen")  # change the name component
lst$male <- NULL   # remove male component
lst

# Task 4
lst$name$last


# 3.10.9 Exercise (string management)

# Intro
str1 <- "Business Analytics (BA) refers to the scientific process of transforming data into insight for making better decisions in business."
str2 <- 'BA can both be seen as the complete decision making process for solving a business problem or as a set of methodologies that enable the creation of business value.'
str3 <- c(str1, str2)  # vector of strings
str3

# The stringr package in tidyverse provides many useful functions for string manipulation. We will consider a few.

str4 <- str_c(str1, str2, "As a process it can be characterized by descriptive, predictive, and prescriptive model building using data sources.",sep = " ")   # join strings
str4

str_c(str3, collapse = " ")    # collapse vector to a string
str_replace(str2, "BA", "Business Analytics")  # replace first occurrence
str_replace_all(str2, "the", "a")              # replace all occurrences
str_remove(str1, " for making better decisions in business")
str_detect(str2, "BA")  # detect a pattern

# Task 1 - Is Business (case sensitive) contained in str1 and str2?
str_detect(str1,"Business")
str_detect(str2,"Business")

# Task 2 - Define a new string that replace BA with Business Analytics in str2
str5 <- str_replace(str2, "BA", "Business Analytics")
str5

# Task 3 - In the string from Question 2, remove or as a set of methodologies that enable the creation of business value
str_remove(str5, " or as a set of methodologies that enable the creation of business value")
str5

# Task 4 - In the string from Question 3, add This course will focus on programming and descriptive analytics.
str5 <- str_c(str5, "This course will focus on programming and descriptive analytics.",sep=" ")
str5

# Task 5
str5 <- str_replace(str5, "analytics", "business analytics")
str5

# Task 6 - Do all calculations in Question 2-5 using pipes.
library(tidyverse)
str_replace(str2, "BA", "Business Analytics") %>% 
  str_remove(" or as a set of methodologies that enable the creation of business value") %>%
  str_c("This course will focus on programming and descriptive analytics.",sep=" ") %>%
  str_replace("analytics", "business analytics")
