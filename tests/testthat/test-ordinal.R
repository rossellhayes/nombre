test_that("simple ordinal", {
  expect_equal(nom_ord(1), "first")
  expect_equal(nom_ord(2), "second")
  expect_equal(nom_ord(3), "third")
  expect_equal(nom_ord(12), "twelfth")
  expect_equal(nom_ord(21), "twenty-first")
  expect_equal(nom_ord(100000000), "one-hundred-millionth")
})

test_that("ordinal vector", {
  expect_equal(
    nom_ord(c(1, 2, 100000000)), c("first", "second", "one-hundred-millionth")
  )
})

test_that("early return", {
  expect_equal(nom_ord(numeric(0)), character(0))
})

test_that("errors", {
  expect_error(nom_ord(character(1)))
  expect_error(nom_ord(numeric(1), negative = numeric(1)))
  expect_error(nom_ord(numeric(1), negative = character(0)))
  expect_error(nom_ord(numeric(1), negative = character(2)))
})
