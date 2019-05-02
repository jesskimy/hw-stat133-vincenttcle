######
# Title: Test binomial
# Description: Includes the tests and expectations for main binomial functions
######

context("Check that main binomial functions work as intended")

test_that("bin_choose gives the correct number of combinations in which k successes can occur in n trials, and that it returns an error if trials or successes is invalid", {
  expect_equal(bin_choose(5, 2), choose(5,2))
  expect_equal(bin_choose(5, 1:3), c(bin_choose(5, 1), bin_choose(5, 2), bin_choose(5, 3)))
  expect_equal(bin_choose(5, 0), 1)
  expect_that(length(bin_choose(5, 1:3)), equals(length(1:3)))
  expect_error(bin_choose(3, 5), "k cannot be greater than n")
})

test_that("bin_probability gives the correct probability of success given a valid value for 'success', 'trials', and 'prob'.", {
  expect_equal(bin_probability(2, 5, 0.5), 0.3125)
  expect_equal(bin_probability(0:2, 5, 0.5), c(0.03125, 0.15625, 0.31250))
  expect_equal(bin_probability(55, 100, .45), 0.01075277)
  expect_error(bin_probability(6, 5, 0.5), "invalid success value")
  expect_error(bin_probability(5, -5, 0.5), "invalid trial value")
  expect_error(bin_probability(4, 5, 2), "p must be a number between 0 and 1")
  expect_is(bin_probability(2, 5, 0.5), "numeric")
})

test_that("bin_distribution returns a data frame of class 'bindis' where success is in the first column, and probability is in the second.", {
  expect_s3_class(bin_distribution(5, 0.5), "bindis")
  expect_is(bin_distribution(5, 0.5), "data.frame")
  expect_equal(nrow(bin_distribution(5, 0.5)), 5+1)
  expect_equal(bin_distribution(5, 0.5)$probability, bin_probability(0:5, 5, 0.5))
  expect_equal(ncol(bin_distribution(5, 0.5)), 2)
})

test_that("bin cumulative returns a data frame of class 'bincum' where success is in the first column, probability is in the second, and cumulative probability is in the third.", {
  expect_equal(bin_cumulative(5, 0.5)$probability, bin_probability(0:5, 5, 0.5))
  expect_equal(ncol(bin_cumulative(5, 0.5)), 3)
  expect_is(bin_cumulative(5, 0.5), "data.frame")
  expect_s3_class(bin_cumulative(5, 0.5), "bincum")
})
