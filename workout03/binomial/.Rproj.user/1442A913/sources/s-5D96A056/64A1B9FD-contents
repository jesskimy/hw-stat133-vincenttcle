######
# Title: Private Auxiliary Functions
# Description: Includes the private functions that will be called by other main functions.
######

#aux_mean() --------------

# title Auxiliary Mean
# description This function gives the expected value, or mean of a binomial distribution
# param trials is a numeric integer that represents the number of trials
# param prob is a numeric value, between 0 and 1, that represents the probability or success.
# return this function returns a numeric value that represents the expected value, or mean.

aux_mean <- function(trials, prob){
  trials*prob
}
aux_mean(10, 0.3)


#aux_variance() --------------

# title Auxiliary variance
# description This function gives the variance of a binomial distribution
# param trials is a numeric integer that represents the number of trials
# param prob is a numeric value, between 0 and 1, that represents the probability or success.
# return this function returns a numeric value that represents the variance.

aux_variance <- function(trials, prob){
  (trials*prob)*(1-prob)
}

aux_variance(10, 0.3)

#aux_skewness() --------------

# title Auxiliary mode
# description This function gives the most likely number of successes in "n" independent trials and "p" probability of success
# param trials is a numeric integer that represents the number of trials
# param prob is a numeric value, between 0 and 1, that represents the probability or success
# return this function returns a numeric value that represents the mode of the probability distribution

aux_mode <- function(trials, prob){
  binom_mode <- (trials*prob) + prob
  if (binom_mode %% 1 == 0){
    return(c(floor(binom_mode), (floor(binom_mode)-1)))
  }else{
    return(floor(binom_mode))
  }
}

aux_mode(9, 0.5)

#aux_skewness() --------------

# title Auxiliary skewness
# description This function gives the skewness of a binomial distribution
# param trials is a numeric integer that represents the number of trials
# param prob is a numeric value, between 0 and 1, that represents the probability or success
# return this function returns a numeric value that represents the skewness of the probability distribution

aux_skewness <- function(trials, prob){
  (1-(2*prob))/sqrt((trials*prob)*(1-prob))
}

aux_skewness(10,0.3)
#aux_kurtosis() --------------

# title Auxiliary kurtosis
# description This function gives the kurtosis of a binomial distribution
# param trials is a numeric integer that represents the number of trials
# param prob is a numeric value, between 0 and 1, that represents the probability or success
# return this function returns a numeric value that represents the kurtosis of the probability distribution

aux_kurtosis <- function(trials, prob){
 (1-(6*prob*(1-prob)))/((trials*prob)*(1-prob))
}

aux_kurtosis(10, 0.3)

