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
