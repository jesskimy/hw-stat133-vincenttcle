######
# Title: Test summary
# Description: Includes the tests and expectations for auxiliary summary functions
######

context("Check that auxiliary summary functions work and return the correct results")

test_that("aux_mean gives the correct numeric output for mean given number of trials and probability of success", {
  expect_equal(aux_mean(10, 0.5), 5)
  expect_equal(aux_mean(60, 0.3), 60*0.3)
  expect_that(length(aux_mean(20, 0.5)), equals(1))
  expect_error(aux_mean(1))
  expect_is(aux_mean(10, 0.5), "numeric")
})

test_that("aux_variance gives the correct numeric output for variance given number of trials and probability of succcess", {
  expect_equal(aux_variance(10, 0.3), 2.1)
  expect_that(length(aux_variance(10, 0.3)), equals(1))
  expect_is(aux_variance(10, 0.3), "numeric")
})


test_that("aux_mode gives the correct numeric output(s) for mode given number of trials and probability of succcess", {
  expect_equal(aux_mode(10, 0.3), 3)
  expect_that(length(aux_mode(10, 0.3)), equals(1))
  expect_that(length(aux_mode(9, 0.5)), equals(2))
  expect_is(aux_mode(10, 0.3), "numeric")
})

test_that("aux_skewness gives the correct numeric output for skewness given number of trials and probability of success", {
  expect_equal(aux_skewness(10, 0.3), (1-(2*0.3))/sqrt((10*0.3)*(1-0.3)))
  expect_that(length(aux_skewness(10, 0.3)), equals(1))
  expect_is(aux_skewness(10, 0.4), "numeric")
})


test_that("aux_kurtosis gives the correct numeric output for kurtosis given number of trials and probability of success", {
  test_kurtosis <- (1-((1-0.3)*(6*0.3)))/((10*0.3)*(1-0.3))
  expect_equal(aux_kurtosis(10, 0.3), test_kurtosis)
  expect_that(length(aux_kurtosis(10, 0.3)), equals(1))
  expect_is(aux_kurtosis(10, 0.3), "numeric")
})

