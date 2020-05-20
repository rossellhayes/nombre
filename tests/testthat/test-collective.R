test_that("simple collective", {
  expect_equal(nom_coll(0), "no")
  expect_equal(nom_coll(1), "the")
  expect_equal(nom_coll(2), "both")
  expect_equal(nom_coll(4), "all four")
})

test_that("collective vector", {
  expect_equal(nom_coll(1:3), c("the", "both", "all three"))
})

test_that("collective max_n", {
  expect_equal(nom_coll(9:10, max_n = 9), c("all nine", "all 10"))
  expect_equal(nom_coll(1:3, max_n = 1), c("the", "both", "all 3"))
})

test_that("early return", {
  expect_equal(nom_coll(numeric(0)), character(0))
})

test_that("errors", {
  expect_error(nom_coll(logical(1)))
})
