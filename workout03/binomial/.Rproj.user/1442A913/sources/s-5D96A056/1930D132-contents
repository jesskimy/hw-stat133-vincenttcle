
The Binomial Package
--------------------

The binomial distribution is one of the most well known distributions in statistics. This package includes functions that are intended to make the calculations for the binomial distribution easier and the outputs clearer.

-   `bin_distribution()` will result in a data frame of class `bindis`, with success in one column and probability of said success in the other.
-   `bin_cumulative()` will result in a data frame of class `bincum`, with success in one column, probability of success in the second, and cumulative probability in the third.
-   `bin_variable()` will return an object of class `binvar`.
-   There are separate `plot()` methods for objects of classes `bindis` and `bincum`.
-   There are specific `print()` methods for objects of classes `binvar` and `summary.binvar`.
-   There is a specific `summary()` method for objects of class `binvar`. Additional documentation and examples can be found in the "vignettes" folder.

Motivation
----------

The point of this package is to explore the possibilities available when creating a package in R. It exposes the individual to all the behind-the-scenes aspects such as testing, auxiliary functions, and private functions.

Installation
------------

To install the package, one must use the `"devtools"` package:

``` r
# development version from GitHub:
install.packages("devtools") 
# install "binomial" (without vignettes)
devtools::install_github("stat133-sp19/hw-stat133-vincenttcle/tree/master/workout03/binomial")
# install "cointoss" (with vignettes)
devtools::install_github("stat133-sp19/hw-stat133-vincenttcle/tree/master/workout03/binomial", build_vignettes = TRUE)
```

Examples of the binomial package in use
---------------------------------------

``` r
library(binomial)

#Finding the probability of 6 heads in 10 flips of a fair coin
bin_probability(success = 6, trials = 10, prob = 0.5)
#> [1] 0.2050781

#Finding the probability of 6 heads in 10 flips of a coin that falls on heads 20% of the time
bin_probability(success = 6, trials = 10, prob = 0.2)
#> [1] 0.005505024

#Looking at the entire binomial distribution of 10 flips of a fair coin
bin_distribution(trials = 10, prob = 0.2)
#>    success  probability
#> 1        0 0.1073741824
#> 2        1 0.2684354560
#> 3        2 0.3019898880
#> 4        3 0.2013265920
#> 5        4 0.0880803840
#> 6        5 0.0264241152
#> 7        6 0.0055050240
#> 8        7 0.0007864320
#> 9        8 0.0000737280
#> 10       9 0.0000040960
#> 11      10 0.0000001024

#Plotting the distribution
bindis_plot <- bin_distribution(trials =  10, prob = 0.5)
plot(bindis_plot)
```

![](README-unnamed-chunk-3-1.png)

``` r

#Looking at the cumulative probability distribution
bin_cumulative(trials = 10, prob = 0.5)
#>    success  probability   cumulative
#> 1        0 0.0009765625 0.0009765625
#> 2        1 0.0097656250 0.0107421875
#> 3        2 0.0439453125 0.0546875000
#> 4        3 0.1171875000 0.1718750000
#> 5        4 0.2050781250 0.3769531250
#> 6        5 0.2460937500 0.6230468750
#> 7        6 0.2050781250 0.8281250000
#> 8        7 0.1171875000 0.9453125000
#> 9        8 0.0439453125 0.9892578125
#> 10       9 0.0097656250 0.9990234375
#> 11      10 0.0009765625 1.0000000000

#Binomial random variable
bin_variable(trials = 10, prob = 0.5)
#> "Binomial Variable" 
#> 
#> Parameters 
#> - number of trials: 10 
#> - prob of success : 0.5

#summary of the binomial random variable
bin_summary <- bin_variable(trials = 10, prob = 0.5)
summary(bin_summary)
#> "Summary Binomial" 
#> 
#> Parameters 
#> - number of trials: 10 
#> - prob of success : 0.5 
#> 
#> Measures 
#> - mean    : 5 
#> - variance: 2.5 
#> - mode    : 5 
#> - skewness: 0 
#> - kurtosis: -0.2
```
