test_that("simple cardinal", {
  expect_equal(nom_card(2), "two")
  expect_equal(
    nom_card(525600), "five hundred twenty-five thousand six hundred"
  )
  expect_equal(nom_card(100000000), "one hundred million")
})

test_that("cardinal vector", {
  expect_equal(
    nom_card(c(2, 525600, 100000000)),
    c(
      "two",
      "five hundred twenty-five thousand six hundred",
      "one hundred million")
    )
})

test_that("cardinal with max_n", {
  expect_equal(nom_card(2, 10), "two")
  expect_equal(nom_card(20, 10), "20")
  expect_equal(nom_card(c(2, 20), 10), c("two", "20"))
  expect_equal(nom_card(c(2, 20), -1), c("2", "20"))
  expect_equal(nom_card(c(20, 20), c(10, 100)), c("20", "twenty"))
})

test_that("negative cardinal", {
  expect_equal(nom_card(-2), "negative two")
  expect_equal(
    nom_card(-525600), "negative five hundred twenty-five thousand six hundred"
  )
  expect_equal(nom_card(-100000000), "negative one hundred million")
  expect_equal(nom_card(-2, negative = "minus"), "minus two")
  expect_equal(
    nom_card(c(-2, -2), negative = c("negative", "minus")),
    c("negative two", "minus two")
  )
})

test_that("decimal cardinal", {
  expect_equal(nom_card(2.9), "two and nine tenths")
  expect_equal(nom_card(1/8), "one eighth")
  expect_equal(nom_card(1/20), "one twentieth")
  expect_equal(nom_card(1/1e10), "zero ten-millionths")
  expect_equal(nom_card(1 - 1/1e10), "ten million ten-millionths")
  expect_equal(
    nom_card(3539/7079),
    "three thousand five hundred thirty-nine seven-thousand-seventy-ninths"
  )
})

test_that("decimal cardinal with frac_args", {
  expect_equal(nom_card(1/2, frac_args = list(base_10 = TRUE)), "five tenths")
  expect_equal(
    nom_card(c(1/2, 3/4), frac_args = list(common_denom = TRUE)),
    c("two quarters", "three quarters")
  )
  expect_equal(
    nom_card(499/1000, frac_args = list(max_denom = 100)), "one half"
  )
})

test_that("early return", {
  expect_equal(nom_card(numeric(0)), character(0))
  expect_equal(nom_numer(numeric(0)), character(0))
  expect_equal(convert_hundreds(numeric(0)), character(0))
})

test_that("errors", {
  expect_error(nom_card(character(1)))
  expect_error(nom_card(numeric(1), negative = numeric(1)))
  expect_error(nom_card(numeric(1), negative = character(0)))
  expect_error(nom_card(numeric(1), negative = character(2)))
  expect_error(nom_card(numeric(1), max_n = numeric(0)))
  expect_error(nom_card(numeric(1), max_n = character(1)))
  expect_error(nom_numer(character(1)))
  expect_error(nom_numer(0.5))
})
