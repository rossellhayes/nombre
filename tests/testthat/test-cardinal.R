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

test_that("negative cardinal", {
  expect_equal(nom_card(-2), "negative two")
  expect_equal(
    nom_card(-525600), "negative five hundred twenty-five thousand six hundred"
  )
  expect_equal(nom_card(-100000000), "negative one hundred million")
})

test_that("decimal cardinal", {
  expect_equal(nom_card(2.9), "two and nine tenths")
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
  expect_error(nom_numer(character(1)))
  expect_error(nom_numer(0.5))
  expect_error(nom_numer(numeric(1), negative = numeric(1)))
  expect_error(nom_numer(numeric(1), negative = character(0)))
  expect_error(nom_numer(numeric(1), negative = character(2)))
})
