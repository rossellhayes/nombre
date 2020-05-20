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

test_that("early return", {
  expect_equal(nom_ord(numeric(0)), character(0))
})
