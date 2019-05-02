######
# Title: Private Checker Functions
# Description: Includes the private functions that check other main functions.
######

#check_prob() --------------

# title Check Probability
# description Checks to see if an input is a proper probability by seeing if it is between or equal to zero or one.
# param prob is a numeric value that represents a probability
# return this function returns "TRUE" if the value for prob falls between 0 and 1. If it doesn't it will return an error "p has to be a number between 0 and 1"

check_prob <- function(prob){
  if (prob <= 1 & prob >= 0){
    return(TRUE)
  }else{
    stop("p must be a number between 0 and 1")
  }
}



#check_trials() --------------

# title Check Trials
# description Checks to see if an input is a valid value by seeing if it is a non negative integer.
# param trials is a numeric value that represents a number of trials
# return this function returns "TRUE" if the value for trials is a non negative integer. If it doesn't it will return an error "invalid trials value"

check_trials <- function(trials){
  if (trials > 0 & trials %% 1 == 0){
    return(TRUE)
  }else{
    stop("invalid trial value")
  }
}




#check_success() --------------

# title Check Success
# description Checks to see if an input is a valid value for successes by seeing if it is less than or equal to the number of trials.
# param success is a numeric non-negative integer or set of integer that represents the number of successes. (ie. 2 = 2 successes of 0:2 = less than or 2 successes)
# param trials is a numeric non-negative integer that represents the number of trials.
# return this function returns "TRUE" if the max value in success is less than trials. If it doesn't it will return an error "invalid success value"

check_success <- function(success, trials){
  floorsuccess <- floor(success)
  sumsuccess <- sum(success)
  abssumsuccess <- sum(abs(success))
  if (sumsuccess == abssumsuccess & sum(success-floorsuccess) == 0){
    if (max(success) <= trials){
      return(TRUE)
    }else{
      stop("invalid success value")
    }
  }else{
    stop("invalid success value")
  }
}





