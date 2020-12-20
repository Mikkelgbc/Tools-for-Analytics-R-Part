# Module 7


# Exercise 7.10.1 (Statistikbanken)

## Done in R Markdown



# Exercise 7.10.2 (tuples in OPL)

## Task 1: Try to generate a text file named test.dat using function write_lines with content

### Read package
library(tidyverse)

### Generate text file
file = "test.dat"

### Write into file
write_lines("nurses = {", file)
write_lines(' <"Anne", 11>', file, append = TRUE)
write_lines('};', file, append = TRUE)

### See file
cat(read_file("test.dat"))



## Task 2

### Install package
remotes::install_github("bss-osca/tfa/tfa-package", dependencies = FALSE)

### Load package
library(tidyverse)

### Define nurses and shifts (read in data from csv file)
nurses <- read_csv(system.file("extdata/nurses.csv", package = "tfa"))
shifts <- read_csv(system.file("extdata/shifts.csv", package = "tfa"))

### Transform data 
nurses %>% mutate(across(where(is.character), ~str_c('"', .x, '"')))



## Task 3
nurses %>% 
  mutate(across(where(is.character), ~str_c('"', .x, '"'))) %>%
  unite("tuple", everything(), sep= ", ", remove = FALSE)



## Task 4
nurses %>% 
  mutate(across(where(is.character), ~str_c('"', .x, '"'))) %>%
  unite("tuple", everything(), sep= ", ", remove = FALSE) %>%
  mutate(tuple = str_c("<", tuple,">"))



## Task 5
nurses %>% 
  mutate(across(where(is.character), ~str_c('"', .x, '"'))) %>%
  unite("tuple", everything(), sep= ", ", remove = FALSE) %>%
  mutate(tuple = str_c("<", tuple,">")) %>%
  pull(tuple) %>%
  str_c(collapse = ",\n")



## Task 6
write_tuple <- function(dat, file){
  write_lines("nurses = {", file, sep = "\n   ")
  
  tuples <- dat %>% 
    mutate(across(where(is.character), ~str_c('"', .x, '"'))) %>%
    unite("tuple", everything(), sep= ", ", remove = FALSE) %>%
    mutate(tuple = str_c("<", tuple,">")) %>%
    pull(tuple) %>%
    str_c(collapse = ",\n   ")
  
  write_lines(tuples, file, append = TRUE)
  write_lines('};', file, append = TRUE)
}

file <- "test.dat"
write_tuple(nurses,file)
cat(read_file("test.dat"))



## Task 7
### The name of an object can be extracted as a string using
deparse(substitute(nurses))

write_tuple <- function(dat, file){
  name <- deparse(substitute(dat))
  write_lines(str_c(name, " = {"), file, sep = "\n   ")
  
  tuples <- dat %>% 
    mutate(across(where(is.character), ~str_c('"', .x, '"'))) %>%
    unite("tuple", everything(), sep= ", ", remove = FALSE) %>%
    mutate(tuple = str_c("<", tuple,">")) %>%
    pull(tuple) %>%
    str_c(collapse = ",\n   ")
  
  write_lines(tuples, file, append = TRUE)
  write_lines('};', file, append = TRUE)
}

file <- "test.dat"
write_tuple(shifts, file)
cat(read_file("test.dat"))



## Task 8
write_tuple <- function(dat, file, append = FALSE){
  name <- deparse(substitute(dat))
  write_lines(str_c(name, " = {"), file, sep = "\n   ", append = append)
  
  tuples <- dat %>% 
    mutate(across(where(is.character), ~str_c('"', .x, '"'))) %>%
    unite("tuple", everything(), sep= ", ", remove = FALSE) %>%
    mutate(tuple = str_c("<", tuple,">")) %>%
    pull(tuple) %>%
    str_c(collapse = ",\n   ")
  
  write_lines(tuples, file, append = TRUE)
  write_lines('};', file, append = TRUE)
}

file <- "test.dat"
write_tuple(shifts, file)
cat(read_file("test.dat"))



## Task 9

file <- "test.dat"
write_tuple(nurses, file)
write_tuple(shifts, file, append = TRUE)
cat(read_file("test.dat"))
