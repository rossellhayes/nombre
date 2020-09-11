test_that('set_config("nombre::max_n", "nombre::negative")', {
  expect_equal(nom_card(1e4), "ten thousand")
  default_max_n <- set_config("nombre::max_n" = 100)
  expect_equal(nom_card(1e4), "10000")

  expect_equal(nom_card(-1), "negative one")
  default_negative <- set_config("nombre::negative" = "minus")
  expect_equal(nom_card(-1), "minus one")

  set_config(default_max_n, default_negative)
  expect_equal(nom_card(1e4), "ten thousand")
  expect_equal(nom_card(-1), "negative one")
})

test_that('set_config("nombre::ord_cardinal")', {
  expect_equal(nom_ord(1), "first")
  default_ord <- set_config("nombre::ord_cardinal" = FALSE)
  expect_equal(nom_ord(1), "1st")
  set_config(default_ord)
  expect_equal(nom_ord(1), "first")
})

test_that('set_config("nombre::quarter")', {
  expect_equal(nom_denom(4), "quarter")
  default_denom <- set_config("nombre::quarter" = FALSE)
  expect_equal(nom_denom(4), "fourth")
  set_config(default_denom)
  expect_equal(nom_denom(4), "quarter")
})

test_that('set_config("nombre::thrice")', {
  expect_equal(nom_adv(3), "three times")
  default_adv <- set_config("nombre::thrice" = TRUE)
  expect_equal(nom_adv(3), "thrice")
  set_config(default_adv)
  expect_equal(nom_adv(3), "three times")
})

test_that('set_config("nombre::of_the", "nombre::all_n")', {
  expect_equal(collective(3), "all three")
  default_coll <- set_config("nombre::all_n" = FALSE, "nombre::of_the" = TRUE)
  expect_equal(collective(3), "all of the")
  set_config(default_coll)
  expect_equal(collective(3), "all three")
  default_coll <- set_config("nombre::coll_cardinal" = FALSE)
  expect_equal(collective(3), "all 3")
  set_config(default_coll)
  expect_equal(collective(3), "all three")
})

test_that("set_config() errors", {
  expect_error(set_config(TRUE))
  expect_error(set_config("foo" = TRUE, TRUE))
  expect_null(get_config("foo"))
})
