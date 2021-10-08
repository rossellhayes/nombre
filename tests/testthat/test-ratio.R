test_that("simple ratio", {
  expect_equal(nom_ratio(2), "two to one")
  expect_equal(nom_ratio(0.5), "one to two")
  expect_equal(nom_ratio(1000), "one thousand to one")
})

test_that("ratio vector", {
  expect_equal(
    nom_ratio(c(2, 0.25, .000001), "in"),
    c("two in one",
      "one in four",
      "one in one million")
  )
})

test_that("ratio with max_n", {
  expect_equal(nom_ratio(2, max_n = 10), "two to one")
  expect_equal(nom_ratio(20, max_n = 10), "20")
  expect_equal(nom_ratio(c(2, 20), max_n = 10), c("two to one", "20"))
  expect_equal(nom_ratio(c(2, 20), max_n = -1), c("2", "20"))
  expect_equal(nom_ratio(c(20, 20), max_n = c(10, 100)), c("20", "twenty to one"))
})

test_that("negative ratio", {
  expect_equal(nom_ratio(-2), "negative two to one")
  expect_equal(
    nom_card(-525600), "negative five hundred twenty-five thousand six hundred"
  )
  expect_equal(nom_ratio(-100000000, sep = "in"), "negative one hundred million in one")
  expect_equal(nom_ratio(-2, negative = "minus"), "minus two to one")
})

test_that("ratio with fracture ...", {
  expect_equal(nom_ratio(1/2, base_10 = TRUE), "five to ten")
  expect_equal(
    nom_ratio(c(0, 1/2, 3/4), common_denom = TRUE),
    c("zero to four",
      "two to four",
      "three to four")
  )
  expect_equal(nom_ratio(27/50, max_denom = 25), "seven to thirteen")
  expect_equal(nom_ratio(15/100, sep = "in", max_denom = 15), "one in seven")
})

test_that("early return", {
  expect_equal(nom_ratio(numeric(0)), character(0))
})

test_that("errors", {
  expect_error(nom_ratio(character(1)))
  expect_error(nom_ratio(numeric(1), negative = numeric(1)))
  expect_error(nom_ratio(numeric(1), negative = character(0)))
  expect_error(nom_ratio(numeric(1), negative = character(2)))
  expect_error(nom_ratio(numeric(1), max_n = numeric(0)))
  expect_error(nom_ratio(numeric(1), max_n = character(1)))
  expect_error(nom_ratio(numeric(1), sep = character(1)))
})
