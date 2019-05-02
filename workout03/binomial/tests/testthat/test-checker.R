######
# Title: Test checks
# Description: Includes the tests and expectations for private checker functions
######


context("Check that checker functions work as intended")


test_that("check_prob works with numeric values between 0 and 1, and returns an error if the input does not match the criteria", {

  expect_true(check_prob(0.5))
  expect_true(check_prob(1))
  expect_that(length(check_prob(0.5)), equals(1))
  expect_error(check_prob(1.1), "p must be a number between 0 and 1")
  expect_error(check_prob(-2), "p must be a number between 0 and 1")
  expect_error(check_prob(1,2))
})


test_that("check_trials takes in a single numeric input and returns TRUE if the input is a positive integer - otherwise it returns an error", {
  expect_true(check_trials(10))
  expect_true(check_trials(1))
  expect_equal(length(check_trials(4)), 1)
  expect_error(check_trials(3,4))
  expect_error(check_trials(0), "invalid trial value")
  expect_error(check_trials(-4), "invalid trial value")
  expect_error(check_trials(1.4), "invalid trial value")
})


test_that("check_success takes in numeric inputs 'success' and 'trials' returns TRUE if the value for success is valid", {
  expect_true(check_success(2,5))
  expect_true(check_success(5,5))
  expect_true(check_success(1:3, 5))
  expect_equal(length(check_success(1:4, 5)), 1)
  expect_error(check_success(1))
  expect_error(check_success(6,5), "invalid success value")
  expect_error(check_success(1:6, 5), "invalid success value")
  expect_error(check_success(-2, 5), "invalid success value")
  expect_error(check_success(c(1, 2.5, 3), 4), "invalid success value")

})
