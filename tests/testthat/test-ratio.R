test_that("simple ratio", {
  expect_equal(nom_ratio(2), "two in one")
  expect_equal(nom_ratio(0.5), "one in two")
  expect_equal(nom_ratio(1000), "one thousand in one")
})

test_that("ratio vector", {
  expect_equal(
    nom_ratio(c(2, 0.25, .000001), "to"),
    c("two to one",
      "one to four",
      "one to one million")
  )
})

test_that("ratio with max_n", {
  expect_equal(nom_ratio(2, max_n = 10), "two in one")
  expect_equal(nom_ratio(20, max_n = 10), "20 in one")
  expect_equal(nom_ratio(c(2, 20), max_n = 10), c("two in one", "20 in one"))
  expect_equal(nom_ratio(c(2, 20), max_n = -1), c("2 in 1", "20 in 1"))
  expect_equal(
    nom_ratio(c(20, 20), max_n = c(10, 100)), c("20 in one", "twenty in one")
  )
})

test_that("negative ratio", {
  expect_equal(nom_ratio(-2), "negative two in one")
  expect_equal(
    nom_card(-525600), "negative five hundred twenty-five thousand six hundred"
  )
  expect_equal(
    nom_ratio(-100000000, sep = "to"), "negative one hundred million to one"
  )
  expect_equal(nom_ratio(-2, negative = "minus"), "minus two in one")
  expect_equal(
    nom_ratio(c(-2, -0.5), negative = c("negative", "minus")),
    c("negative two in one", "minus one in two")
  )
})

test_that("ratio with fracture ...", {
  expect_equal(nom_ratio(1/2, base_10 = TRUE), "five in ten")
  expect_equal(
    nom_ratio(c(0, 1/2, 3/4), common_denom = TRUE),
    c("zero in four",
      "two in four",
      "three in four")
  )
  expect_equal(nom_ratio(27/50, max_denom = 25), "seven in thirteen")
  expect_equal(nom_ratio(15/100, sep = "to", max_denom = 15), "one to seven")
})

test_that("non-finite", {
  expect_equal(nom_ratio(c(NA, 2)), c(NA, "two in one"))

  skip_if_not_installed("fracture", "0.2.0.9001")

  expect_equal(
    nom_ratio(c(NA, 2, Inf, NaN, NA)),
    c(NA, "two in one", "infinity in one", NaN, NA)
  )
})

test_that("early return", {
  expect_equal(nom_ratio(NA), NA_character_)
  expect_equal(nom_ratio(numeric(0)), character(0))
})

test_that("errors", {
  expect_error(nom_ratio(character(1)))
  expect_error(nom_ratio(numeric(1), negative = numeric(1)))
  expect_error(nom_ratio(numeric(1), negative = character(0)))
  expect_error(nom_ratio(numeric(1), negative = character(2)))
  expect_error(nom_ratio(numeric(1), max_n = numeric(0)))
  expect_error(nom_ratio(numeric(1), max_n = character(1)))
})
