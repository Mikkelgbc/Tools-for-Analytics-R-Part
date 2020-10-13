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








