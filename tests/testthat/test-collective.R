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

test_that("collective of_the", {
  expect_equal(collective(0:3), c("no", "the", "both", "all three"))
  expect_equal(
    collective(0:3, of_the = TRUE),
    c("none of the", "the", "both of the", "all three of the")
  )
})

test_that("collective all_n", {
  expect_equal(collective(3),                               "all three")
  expect_equal(collective(3, all_n = FALSE),                "all")
  expect_equal(collective(3, all_n = FALSE, of_the = TRUE), "all of the")
})

test_that("non-finite", {
  expect_equal(
    nom_coll(c(NA, 2, Inf, NaN, NA)),
    c(NA, "both", "all infinity", NaN, NA)
  )
})

test_that("early return", {
  expect_equal(nom_coll(NA), NA_character_)
  expect_equal(nom_coll(numeric(0)), character(0))
})

test_that("errors", {
  expect_error(nom_coll(logical(1)))
})
