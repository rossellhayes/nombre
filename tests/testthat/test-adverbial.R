test_that("simple adverbial", {
  expect_equal(nom_adv(1), "once")
  expect_equal(nom_adv(2), "twice")
  expect_equal(nom_adv(4), "four times")
})

test_that("adverbial vector", {
  expect_equal(nom_adv(1:2), c("once", "twice"))
  expect_equal(nom_adv(4:5), c("four times", "five times"))
})

test_that("thrice", {
  expect_equal(nom_adv(3, thrice = FALSE), "three times")
  expect_equal(nom_adv(3, thrice = TRUE), "thrice")
})

test_that("adverbial max_n", {
  expect_equal(nom_adv(9:10, max_n = 9), c("nine times", "10 times"))
  expect_equal(nom_adv(1:2, max_n = 1), c("once", "2 times"))
})

test_that("non-finite", {
  expect_equal(
    nom_adv(c(NA, 2, Inf, NaN, NA)),
    c(NA, "twice", "infinity times", NaN, NA)
  )
})

test_that("early return", {
  expect_equal(nom_adv(NA), NA_character_)
  expect_equal(nom_adv(numeric(0)), character(0))
})

test_that("errors", {
  expect_error(nom_adv(logical(1)))
  expect_error(nom_adv(numeric(1), thrice = numeric(1)))
  expect_error(nom_adv(numeric(1), thrice = logical(2)))
  expect_error(nom_adv(numeric(1), thrice = NA))
})
