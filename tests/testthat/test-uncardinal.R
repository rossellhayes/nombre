test_that("uncardinal", {
  expect_equal(uncardinal("zero"), 0)
  expect_equal(uncardinal("one"),  1)

  expect_equal(uncardinal(c("one", "two", "three")), c(1, 2, 3))

  expect_equal(uncardinal("infinity"),          Inf)
  expect_equal(uncardinal("negative infinity"), -Inf)

  x <- c(
    -1000:1e4,
    sample(c(1, -1), 1e4, replace = TRUE) * 10 ^ runif(1e4, 5, 15.95) %/% 1
  )

  cardinal_x <- suppressWarnings(cardinal(x))
  expect_equal(uncardinal(as.character(cardinal_x)), x)
})

test_that("uncardinal with class nombre", {
  expect_equal(uncardinal(cardinal(0)), 0)
  expect_equal(uncardinal(ordinal(25)), 25)
})

test_that("uncardinal warning", {
  expect_warning(uncardinal("one and a half"), "integer cardinals")
  expect_warning(uncardinal(letters[1:6]), "and one more")
})
