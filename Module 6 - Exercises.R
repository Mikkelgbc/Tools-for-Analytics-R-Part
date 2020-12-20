# Module 6


# Exercise 6.7.1 - Load tfa package
remotes::install_github("bss-osca/tfa/tfa-package")
library(tfa)

# Task 1 & 2
# Done in R Markdown

# Task 3
# Answer: All the code is now hidden. But not the output.

# Task 4 to 7
# Done in R Markdown


# Exercise 6.7.2

# Task 1
library(tidyverse)
airquality %>% as_tibble()


# Task 2
airquality
airquality %>% as_tibble()

# Answer: tibble only shows the first 10 rows, while dataframe shows all rows


# Task 3
dat <- tibble(name = c("Hans", "Ole"), 
              age = c(23, 45), 
              misc = list(
                list(status = 1, comment = "To young"), 
                list(comment = "Potential candidate")))
dat

dat$misc[[1]]
