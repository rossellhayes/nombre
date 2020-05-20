test_that("simple denominator", {
  expect_equal(nom_denom(1), "whole")
  expect_equal(nom_denom(2), "half")
  expect_equal(nom_denom(3), "third")
  expect_equal(nom_denom(12), "twelfth")
  expect_equal(nom_denom(21), "twenty-first")
  expect_equal(nom_denom(100000000), "one-hundred-millionth")
})

test_that("plural denominator", {
  expect_equal(nom_denom(1, 2), "wholes")
  expect_equal(nom_denom(2, 2), "halves")
  expect_equal(nom_denom(3, 2), "thirds")
  expect_equal(nom_denom(12, 2), "twelfths")
  expect_equal(nom_denom(21, 2), "twenty-firsts")
  expect_equal(nom_denom(100000000, 2), "one-hundred-millionths")
})

test_that("denominator vector", {
  expect_equal(
    nom_denom(c(1, 2, 100000000)), c("whole", "half", "one-hundred-millionth")
  )
  expect_equal(
    nom_denom(c(1, 2, 100000000), 1:3),
    c("whole", "halves", "one-hundred-millionths")
  )
})

test_that("quarter", {
  expect_equal(nom_denom(4), "quarter")
  expect_equal(nom_denom(4, quarter = FALSE), "fourth")
})

test_that("denominator with max_n", {
  expect_equal(nom_denom(2, 2, max_n = 10), "halves")
  expect_equal(nom_denom(20, 2, max_n = 10), "20ths")
  expect_equal(nom_denom(c(2, 20), 2, max_n = 10), c("halves", "20ths"))
  expect_equal(
    nom_denom(c(20, 20), 2, max_n = c(10, 100)), c("20ths", "twentieths")
  )
})

test_that("early return", {
  expect_equal(nom_denom(numeric(0)), character(0))
})

test_that("errors", {
  expect_error(nom_denom(character(1)))
  expect_error(nom_denom(numeric(1), negative = numeric(1)))
  expect_error(nom_denom(numeric(1), negative = character(0)))
  expect_error(nom_denom(numeric(1), negative = character(2)))
  expect_error(nom_denom(numeric(1), numerator = character(1)))
  expect_error(nom_denom(numeric(2), numerator = numeric(3)))
  expect_error(nom_denom(numeric(2), negative = numeric(3)))
  expect_error(nom_denom(numeric(2), quarter = numeric(1)))
  expect_error(nom_denom(numeric(2), quarter = NA))
  expect_error(nom_denom(numeric(2), quarter = logical(2)))
})
