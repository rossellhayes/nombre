test_that("simple ordinal", {
  expect_equal(nom_ord(1), "first")
  expect_equal(nom_ord(2), "second")
  expect_equal(nom_ord(3), "third")
  expect_equal(nom_ord(12), "twelfth")
  expect_equal(nom_ord(21), "twenty-first")
  expect_equal(nom_ord(100000000), "one-hundred-millionth")
})

test_that("ordinal fraction", {
  expect_equal(nom_ord(9 + 3/4), c("nine-and-three-quartersth"))
})

test_that("ordinal vector", {
  expect_equal(
    nom_ord(c(1, 2, 100000000)), c("first", "second", "one-hundred-millionth")
  )
})

test_that("ordinal suffixes without cardinalizing", {
  expect_equal(nom_ord(1, cardinal = FALSE), "1st")
  expect_equal(nom_ord(2, cardinal = FALSE), "2nd")
  expect_equal(nom_ord(3, cardinal = FALSE), "3rd")
  expect_equal(nom_ord(12, cardinal = FALSE), "12th")
  expect_equal(nom_ord(21, cardinal = FALSE), "21st")
  expect_equal(nom_ord(100000000, cardinal = FALSE), "100000000th")
  expect_equal(nom_ord(c(9, 10), cardinal = FALSE), c("9th", "10th"))
})

test_that("ordinal with max_n", {
  expect_equal(nom_ord(2, max_n = 10), "second")
  expect_equal(nom_ord(20, max_n = 10), "20th")
  expect_equal(nom_ord(c(2, 20), max_n = 10), c("second", "20th"))
  expect_equal(nom_ord(c(20, 20), max_n = c(10, 100)), c("20th", "twentieth"))
})

test_that("ordinal suffixes on character vector", {
  expect_equal(nom_ord("1"), "1st")
  expect_equal(nom_ord("2"), "2nd")
  expect_equal(nom_ord("3"), "3rd")
  expect_equal(nom_ord("12"), "12th")
  expect_equal(nom_ord("21"), "21st")
  expect_equal(nom_ord("100000000"), "100000000th")
  expect_equal(nom_ord("one"), "first")
  expect_equal(nom_ord("two"), "second")
  expect_equal(nom_ord("three"), "third")
  expect_equal(nom_ord("twelve"), "twelfth")
  expect_equal(nom_ord("twenty-one"), "twenty-first")
  expect_equal(nom_ord("one hundred million"), "one-hundred-millionth")
  expect_equal(nom_ord("n"), "nth")
  expect_equal(nom_ord("dozen"), "dozenth")
  expect_equal(nom_ord("umpteen"), "umpteenth")
  expect_equal(nom_ord("eleventy"), "eleventieth")
  expect_equal(nom_ord("one zillion"), "one-zillionth")
})

test_that("early return", {
  expect_equal(nom_ord(numeric(0)), character(0))
})

test_that("errors", {
  expect_error(nom_ord(logical(1)))
  expect_error(nom_ord(numeric(1), negative = numeric(1)))
  expect_error(nom_ord(numeric(1), negative = character(0)))
  expect_error(nom_ord(numeric(1), negative = character(2)))
})
