library(tidyverse)

# Exercise 1
dice <- 1:6
card_suit <- c("clubs", "diamonds", "hearts", "spades")
card_number <- c("ace", 2:10, "jack", "queen", "king")
ite <- expand_grid(Dice = dice, 
                   Card_suit = card_suit, 
                   Card_number = card_number)  
for (r in 1:nrow(ite)) { # iterate over rows
  cat("Dice = ", ite$Dice[r], " and card = ", ite$Card_number[r], " (", ite$Card_suit[r], ").\n", sep="")
}


# Exercise 2
get_combinations <- function(dice, card) {
  ite <- expand_grid(d = dice, c = card)
  found <- FALSE
  for (i in 1:nrow(ite)) {
    if (ite$d[i] == 2) found == TRUE
    cat("Dice = ", ite$d[i], " and card = ", ite$c[i], ".\n", sep="")
  } 
  return(found)
}
get_combinations(dice = c(2,3), card = c("2-spade", "ace-dimond"))
get_combinations(dice = c(3,1), card = c("10-heart", "king-dimond"))


# Exercise 3
PV <- function(FV, r = 0.1, n, round = FALSE){
  PV <- FV/(1+r)^n
  if (round) return(round(PV,2))
  return(PV)
}

PV(100, n = 7)
PV(100, n = 7,round=TRUE)
PV(100, n = 10)
