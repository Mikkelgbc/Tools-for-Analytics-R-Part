# 5.8.1 Exercise (defining functions)
# Solve this exercise using a script file

# Task 1: Create a function sum_n that for any given value, say  n, computes the sum of the integers from 1 to n (inclusive). 
# Use the function to determine the sum of integers from 1 to 5000. Document your function too.

sum_n <- function(n){
  return(sum(1:n))
}

sum_n(5000)

# Task 2: Write a function compute_s_n that for any given n computes the sum
compute_s_n <- function(n){
  return(sum((1:n)^2))
}

compute_s_n(10)

# Task 3: Define an empty numerical vector s_n of size 25 and store in the results using a for-loop. Confirm that the formula for the sum is
s_n <- vector("numeric",25)

for(n in 1:25){
  s_n[n] <- compute_s_n(n)
}
s_n

compute_s_n_alt <- function(n){
  return(n*(n+1)*(2*n+1)/6)
}

for(n in 1:25){
  if (s_n[n] != compute_s_n_alt(n)){
    cat('Error!')
    break
  }
}

compute_s_n_alt(n)

# Task 4
