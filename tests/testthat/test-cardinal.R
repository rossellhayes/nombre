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
