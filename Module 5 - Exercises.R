# Module 5


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

# Task 4: Write a function biggest which takes two integers as arguments. Let the function return 1 if the first argument is larger than the second and return 0 otherwise.
biggest <- function(a, b){
  if(a > b) return(1)
  return(0)
}

# Task 5: Write a function that returns the shipping cost as 10% of the total cost of an order (input argument).
ShippingCost <- function(total){
  return(0.1*total)
}

ShippingCost(450)

# Task 6: Given Question 5, rewrite the function so the percentage is an input argument with a default of 10%
ShippingCost <- function(total,pct=0.1){
  return(pct*total)
}

ShippingCost(450)

ShippingCost(450,0.2)

# Task 7: Given Question 5, the shipping cost can be split into parts. One part is gasoline which is 50% of the shipping cost. 
# Write a function that has total cost as input argument and calculate the gasoline cost and use the function defined in Question 5 inside it

GasolineCost <- function(total){
  return(0.5*ShippingCost(total))
}

GasolineCost(450)

# Task 8: Given Question 6, the shipping cost can be split into parts. One part is gasoline which is 50% of the shipping cost. 
# Write a function that has total cost a input argument and calculate the gasoline cost and use the function defined in Question 6 inside it. 
# Hint: Use the ... argument to pass arguments to shipping_cost.

GasolineCost <- function(total,...){
  return(0.5*ShippingCost(total))
}

GasolineCost(450)

# Task 9: Given Question 8, write a function costs that, given total cost, returns the total cost, shipping cost and gasoline cost.
costs <- function(total,...){
  lst <- list(Total = total, Shipping = ShippingCost(total,...), Gasoline = GasolineCost(total,...))
  return(lst)
}

costs(450)


# 5.8.2 Exercise (scope)

# Task 1: After running the code below, what is the value of variable x?
x <- 3

my_func <- function(y){
  x <- 5
  return(y+5)
}

my_func(7)

# Answer: The value of x is 3, as the "x <- 5" is contained within the function (Local variable)

# Task 2: Is there any problems with the following code?
x <- 3

my_func <- function(y){
  return(y+x)
}

my_func(7)

# Answer: The code runs. But it is not good coding practice to call global variables inside a function (x). Instead x should have been an argument to the function.

# Task 3: Have a look at the documentation for operator <<- (run ?'<--'). After running the code below, what is the value of variable x?
x <- 3

my_func <- function(y){
  x <- 4
  x <<- 5
  return(y+5)
}

# Answer: That value is still 3 since my_func has not been called yet.

# Task 4: After running the code below, what is the value of variable x and output of the function call?
x <- 3

my_func <- function(y){
  x <- 4
  x <<- 5
  return(y+5)
}

my_func(7)

x

# Answer: That value of x is 5 since <<- is used to look at the parent environment. 
# The function call returns 11 since the x used is the local variable. 
# In general avoid using <<- and give local variables different names compared to global ones.


# 5.8.3 Exercise (job sequencing)

# Solve this exercise using a script file.
# This exercise is based on Exercise 6.12 in Wøhlk (2010).

# Consider a problem of determining the best sequencing of jobs on a machine. A set of startup costs are given for 5 machines:
startup_costs <- c(27, 28, 32, 35, 26)

startup_costs

# Moreover, when changing from one job to another job, the setup costs are given as:
setup_costs <- matrix(c(
  NA, 35, 22, 44, 12,
  49, NA, 46, 38, 17,
  46, 12, NA, 29, 41,
  23, 37, 31, NA, 26,
  17, 23, 28, 34, NA), 
  byrow = TRUE, nrow = 5)

setup_costs

# The goal of the problem is to determine a sequence of jobs which minimizes the total setup cost including the startup cost.

# One possible way to find a sequence is the use a greedy strategy:
# Greedy Algorithm
# Step 0: Start with the job which has minimal startup cost.
# Step 1: Select the next job as the job not already done with minimal setup cost given current job.
# Step 2: Set next job in Step 1 to current job and go to Step 1 if not all jobs are done.

greedy <- function(startup, setup) {
  jobs <- nrow(setup)
  cur_job <- which.min(startup)
  cost <- startup[cur_job]
  
  # cat("Start job:", cur_job, "\n")
  job_seq <- cur_job
  setup[, cur_job] <- NA
  
  for (i in 1:(jobs-1)) {
    next_job <- which.min(setup[cur_job, ])
    
    # cat("Next job:", next_job, "\n") 
    cost <- cost + setup[cur_job, next_job]
    job_seq <- c(job_seq, next_job)
    cur_job <- next_job
    setup[, cur_job] <- NA
  }
  # print(setup)
  return(list(seq = job_seq, cost = cost))
}

greedy(startup_costs, setup_costs)

# First, the job with minimum startup cost is found using function which.min and we define cost as the startup cost. 
# We use cat to make some debugging statements and initialize job_seq with the first job. 
# Next, we have to find a way of ignoring jobs already done. 
# We do that here by setting the columns of setup cost equal to NA for jobs already done. 
# Hence, they will not be selected by which.min. The for loop runs 4 times and selects jobs and accumulate the total cost.

# A well-known better strategy is to:
# Better Algorithm
# Step 0: Subtract minimum of startup and setup cost for each job from setup and startup costs (that is columnwise)
# Step 1: Call the greedy algorithm with the modified costs. Note that the total cost returned has to be modified a bit.

# Task: Implement a better function calculating a better strategy. Hint: to find the minimum column costs, you may use apply(rbind(startup, setup), 2, min, na.rm = T).
better <- function(startup,setup){
  jobs <- nrow(setup)
  min_col_val <- apply(rbind (startup, setup), 2, min, na.rm = TRUE)
  startup <- startup - min_col_val
  min_mat <- matrix(rep(min_col_val, jobs), ncol=jobs, byrow=TRUE)
  setup <- setup - min_mat
  lst <- greedy(startup, setup)
  lst$cost <- lst$cost + sum(min_col_val)
  return(lst)
}

better(startup_costs, setup_costs)
