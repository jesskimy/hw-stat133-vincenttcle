######
# Title: Main Functions
# Description: Includes the main functions of the package, as well as methods that support the main functions.
######
source("R/private_aux.R")
source("R/privatechecker.R")



  #Bin Choose ---------------------------------

#' @title Bin Choose
#' @description This function calculates the number of combinations in which k successes can occur in n trials
#' @param n is a numeric integer that represents the number of trials
#' @param k is a numeric value, or vector of values that represents the number of successes
#' @return this function returns a numeric value that represents the number of combinations in which k successes can occur in n trials.
#' @examples
#' bin_choose(n = 5, k = 2)
#' bin_choose(5, 0)
#' bin_choose(5, 1:3)
#' @export
#'
bin_choose <- function(n, k){
  if (max(k) > n){
    stop("k cannot be greater than n")
  }else{
    factorial(n)/(factorial(k)*factorial(n-k))
    }
  }

bin_choose(n = 5, k = 2)
bin_choose(5,0)
bin_choose(5, (1:3))




  #Bin Probability ---------------------------------

#' @title Bin Probability
#' @description This function calculates the probability of getting "k" successes in "n" trials given a probability of one success "prob"
#' @param success is a numeric integer or a vector of integers that represents the number of successes observed
#' @param trials is a numeric integer that represents the number of trials
#' @param prob is a numeric value between 0 and 1 that represents the probability of success
#' @return this function returns a numeric value that represents the probability of "k" successes in "n" trials
#' @examples
#' bin_probability(success = 2, trials = 5, prob = 0.5)
#' bin_probability(success = 0:2, trials = 5, prob = 0.5)
#' bin_probability(success = 55, trials = 100, prob = 0.45)
#' @export
#'
bin_probability <- function(success, trials, prob){
  if (check_trials(trials) != "TRUE"){
    stop("invalid trials value")
  }else if (check_prob(prob) != "TRUE"){
    stop("invalid probability value")
  }else if (check_success(success, trials) != "TRUE"){
    stop("invalid success value")
  }else{
    bin_choose(trials, success)*((prob^success)*((1-prob)^(trials - success)))
  }
}


bin_probability(2,5,0.5)
bin_probability(55, 100, 0.45)
bin_probability(0:2, 5, 0.5)





  #Bin Distribution (function) ---------------------------------

#' @title Bin distribution
#' @description This function creates a data frame with the number of successes in one column and the probability of those successes in another
#' @param trials is a numeric integer that represents the number of trials
#' @param prob is a numeric value between 0 and 1 that represents the probability of success
#' @return this function returns a data frame with two columns - "success" and "probability". Both contain numeric values representing the number of success and the corresponding successes, respectively
#' @examples
#' bin_distribution(trials = 5, prob = 0.5)
#' bin_distribution(trials = 100, prob = 0.2)
#' bin_distribution(trials = 45, prob = 0.75)
#' @export
#'
bin_distribution <- function(trials, prob){
  col1 <- 0:trials
  col2 <- bin_probability(0:trials, trials, prob)
  bindis_df <- data.frame(col1, col2)
  names(bindis_df) <- c("success", "probability")
  class(bindis_df) <- c("bindis", "data.frame")
  return(bindis_df)
}

dis1 <- bin_distribution(5, 0.5)




  #Plot Bindis (method) ---------------------------------

#' @export
plot.bindis <- function(df){
   ggplot(df, aes(x = df$success, y = df$probability)) +
    geom_col(col = "blue", fill = "gold") +
    labs(x = "successes", y = "probability", title = "Probability Histogram") +
    scale_x_continuous(breaks = round(seq(0, nrow(df), by = 1))) +
    theme_gray()
}


plot(dis1)



  #Bin Cumulative (function) ---------------------------------

#' @title Bin cumulative
#' @description This function creates a data frame of classes data.frame and bincum with the number of successes in one column, the probability of those successes in the middle, and cumulative probability in the third.
#' @param trials is a numeric integer that represents the number of trials
#' @param prob is a numeric value between 0 and 1 that represents the probability of success
#' @return this function returns a data frame with three columns - "success", "probability" and "cumulative". All three contain numeric values.
#' @examples
#' bin_cumulative(trials = 5, prob = 0.5)
#' bin_cumulative(trials = 100, prob = 0.2)
#' bin_cumulative(trials = 45, prob = 0.75)
#' @export
#'
bin_cumulative <- function(trials, prob){
  cumulative <- c()
  probsum <- 0
  probabilities <- bin_distribution(trials, prob)[,2]
  for (i in 1:length(probabilities)){
    probsum <- probsum + probabilities[i]
    cumulative[i] <- probsum
  }
  cumulative_df <- cbind(bin_distribution(trials, prob), cumulative)
  class(cumulative_df) <- c("bincum", "data.frame")
  return(cumulative_df)
}

bin_cumulative(5, 0.5)




  #Plot Cumulative (method) ---------------------------------

#' @export
plot.bincum <- function(bincumdf){
  ggplot(bincumdf, aes(success, cumulative)) +
    geom_point(shape = 21, size = 2, stroke = 2) +
    geom_line(lwd = 1) +
    labs(title = "Cumulative Distribution")
}

dis2 <- bin_cumulative(trials = 5, prob = 0.5)
plot(dis2)




  #Bin Variable (function) ---------------------------------

#' @title Bin variable
#' @description This function returns a list of class binvar with elements "trials" and "prob", where "trials" is the number of trials and "prob" is the corresponding probability of success.
#' @param trials is a numeric integer that represents the number of trials
#' @param prob is a numeric value between 0 and 1 that represents the probability of success
#' @return a list with two elements: "trials" and "prob". All values in both elements will be numeric.
#' @examples
#' bin_variable(trials = 5, prob = 0.5)
#' bin_variable(trials = 100, prob = 0.2)
#' bin_variable(trials = 45, prob = 0.75)
#' @export
#'
bin_variable <- function(trials, prob){
  if (check_trials(trials) != "TRUE"){
    stop("invalid trials value")
  }else if (check_prob(prob) != "TRUE"){
    stop("invalid probability value")
  }else{
    bin_var <- list(
      "trials" = trials,
      "prob" = prob
    )
    class(bin_var) <- "binvar"
    return(bin_var)
  }
}

bin_variable(trials = 10, p = 0.3)




  #Print binvar (method) ---------------------------------

#' @export
#'
print.binvar <- function(bin_var){
  cat(paste('"Binomial Variable" \n\nParameters \n- number of trials:', bin_var$trials, '\n- prob of success :', bin_var$prob))
}

bin1 <- bin_variable(trials = 10, p = 0.3)
bin1




  #summary binvar (method) ---------------------------------

#' @export
#'
summary.binvar <- function(bin_var){
  summary_bin_var <- list(
    "trials" = bin_var$trials,
    "prob" = bin_var$prob,
    "mean" = aux_mean(bin_var$trials, bin_var$prob),
    "variance" = aux_variance(bin_var$trials, bin_var$prob),
    "mode" = aux_mode(bin_var$trials, bin_var$prob),
    "skewness" = aux_skewness(bin_var$trials, bin_var$prob),
    "kurtosis" = aux_kurtosis(bin_var$trials, bin_var$prob)
  )
  class(summary_bin_var) <- "summary.binvar"
  return(summary_bin_var)
}




  #print summary binvar (method) ---------------------------------

#' @export
#'
print.summary.binvar <- function(summary_bin_var){
  cat(paste('"Summary Binomial" \n\nParameters \n- number of trials:', summary_bin_var$trials,
            '\n- prob of success :', summary_bin_var$prob,
            '\n\nMeasures \n- mean    :', summary_bin_var$mean,
            '\n- variance:', summary_bin_var$variance,
            '\n- mode    :', summary_bin_var$mode,
            '\n- skewness:', noquote(format(summary_bin_var$skewness, digits = 7)),
            '\n- kurtosis:', noquote(format(summary_bin_var$kurtosis, digits = 7))))
}


bin1 <- bin_variable(trials = 10, p = 0.3)
binsum1 <- summary(bin1)
binsum1




  #bin mean (function) ---------------------------------

#' @title Bin mean
#' @description This function gives the expected value, or mean of a binomial distribution
#' @param trials is a numeric integer that represents the number of trials
#' @param prob is a numeric value between 0 and 1 that represents the probability of success
#' @return this function returns a numeric value that represents the expected value, or mean of the binomial distribution
#' @examples
#' bin_mean(trials = 5, prob = 0.5)
#' bin_mean(trials = 100, prob = 0.2)
#' bin_mean(trials = 45, prob = 0.75)
#' @export
#'
bin_mean <- function(trials, prob){
  if (check_trials(trials) != "TRUE"){
    stop("invalid trials value")
  }else if (check_prob(prob) != "TRUE"){
    stop("invalid probability value")
  }else{
    aux_mean(trials, prob)
  }
}

bin_mean(10, 0.3)




  #bin variance (function) ---------------------------------

#' @title Bin variance
#' @description This function gives the variance of a binomial distribution
#' @param trials is a numeric integer that represents the number of trials
#' @param prob is a numeric value between 0 and 1 that represents the probability of success
#' @return this function returns a numeric value that represents the variance
#' @examples
#' bin_variance(trials = 5, prob = 0.5)
#' bin_variance(trials = 100, prob = 0.2)
#' bin_variance(trials = 45, prob = 0.75)
#' @export
#'
bin_variance <- function(trials, prob){
  if (check_trials(trials) != "TRUE"){
    stop("invalid trials value")
  }else if (check_prob(prob) != "TRUE"){
    stop("invalid probability value")
  }else{
    aux_variance(trials, prob)
  }
}


bin_variance(10, 0.3)




  #bin mode (function) ---------------------------------

#' @title Bin mode
#' @description This function gives the most likely number of successes in "trials" independent trials and "prob" probability of success
#' @param trials is a numeric integer that represents the number of trials
#' @param prob is a numeric value between 0 and 1 that represents the probability of success
#' @return this function returns a numeric value that represents the mode of the probability distribution
#' @examples
#' bin_mode(trials = 5, prob = 0.5)
#' bin_mode(trials = 100, prob = 0.2)
#' bin_mode(trials = 45, prob = 0.75)
#' @export
#'
bin_mode <- function(trials, prob){
  if (check_trials(trials) != "TRUE"){
    stop("invalid trials value")
  }else if (check_prob(prob) != "TRUE"){
    stop("invalid probability value")
  }else{
    aux_mode(trials, prob)
  }
}

bin_mode(10, 0.3)




  #bin skewness (function) ---------------------------------
#' @title Bin skewness
#' @description This function gives the skewness of a binomial distribution
#' @param trials is a numeric integer that represents the number of trials
#' @param prob is a numeric value, between 0 and 1, that represents the probability or success
#' @return this function returns a numeric value that represents the skewness of the probability distribution
#' @examples
#' bin_skewness(trials = 5, prob = 0.5)
#' bin_skewness(trials = 100, prob = 0.2)
#' bin_skewness(trials = 45, prob = 0.75)
#' @export
#'
bin_skewness <- function(trials, prob){
  if (check_trials(trials) != "TRUE"){
    stop("invalid trials value")
  }else if (check_prob(prob) != "TRUE"){
    stop("invalid probability value")
  }else{
    aux_skewness(trials, prob)
  }
}

bin_skewness(10, 0.3)




  #bin kurtosis (function) ---------------------------------

#' @title Bin kurtosis
#' @description This function gives the kurtosis of a binomial distribution
#' @param trials is a numeric integer that represents the number of trials
#' @param prob is a numeric value, between 0 and 1, that represents the probability or success
#' @return this function returns a numeric value that represents the kurtosis of the probability distribution
#' @examples
#' bin_kurtosis(trials = 5, prob = 0.5)
#' bin_kurtosis(trials = 100, prob = 0.2)
#' bin_kurtosis(trials = 45, prob = 0.75)
#' @export
#'
bin_kurtosis <- function(trials, prob){
  if (check_trials(trials) != "TRUE"){
    stop("invalid trials value")
  }else if (check_prob(prob) != "TRUE"){
    stop("invalid probability value")
  }else{
    aux_kurtosis(trials, prob)
  }
}

bin_kurtosis(10, 0.3)
