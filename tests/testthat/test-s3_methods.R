test_that("s3 class", {
  expect_s3_class(cardinal(25),    "nombre")
  expect_s3_class(ordinal(25),     "nombre")
  expect_s3_class(numerator(25),   "nombre")
  expect_s3_class(denominator(25), "nombre")
  expect_s3_class(adverbial(25),   "nombre")
  expect_s3_class(collective(25),  "nombre")

  expect_equal(attr(cardinal(25),    "nombre"), "cardinal")
  expect_equal(attr(ordinal(25),     "nombre"), "ordinal")
  expect_equal(attr(numerator(25),   "nombre"), "numerator")
  expect_equal(attr(denominator(25), "nombre"), "denominator")
  expect_equal(attr(adverbial(25),   "nombre"), "adverbial")
  expect_equal(attr(collective(25),  "nombre"), "collective")
})

test_that("as.character()", {
  expect_equal(as.character(cardinal(25)), "twenty-five")
  expect_equal(as.character(cardinal(2.5)), "two and one half")

  expect_equal(as.character(ordinal(25)),     "twenty-fifth")
  expect_equal(as.character(numerator(25)),   "twenty-five")
  expect_equal(as.character(denominator(25)), "twenty-fifth")
  expect_equal(as.character(adverbial(25)),   "twenty-five times")
  expect_equal(as.character(collective(25)),  "all twenty-five")
})

test_that("print()", {
  expect_output(print(cardinal(25)), "twenty-five")
  expect_output(print(cardinal(2.5)), "two and one half")

  expect_output(print(ordinal(25)),     "twenty-fifth")
  expect_output(print(numerator(25)),   "twenty-five")
  expect_output(print(denominator(25)), "twenty-fifth")
  expect_output(print(adverbial(25)),   "twenty-five times")
  expect_output(print(collective(25)),  "all twenty-five")
})

test_that("as.numeric()", {
  expect_equal(as.numeric(cardinal(25)), 25)
  expect_equal(as.numeric(cardinal(2.5)), 2.5)

  expect_equal(as.numeric(ordinal(25)),     25)
  expect_equal(as.numeric(numerator(25)),   25)
  expect_equal(as.numeric(denominator(25)), 25)
  expect_equal(as.numeric(adverbial(25)),   25)
  expect_equal(as.numeric(collective(25)),  25)
})

test_that("as.integer()", {
  expect_equal(as.integer(cardinal(25)), 25L)
  expect_equal(as.integer(cardinal(2.5)), 2L)

  expect_equal(as.integer(ordinal(25)),     25L)
  expect_equal(as.integer(numerator(25)),   25L)
  expect_equal(as.integer(denominator(25)), 25L)
  expect_equal(as.integer(adverbial(25)),   25L)
  expect_equal(as.integer(collective(25)),  25L)
})

test_that("Math", {
  expect_equal(abs(cardinal(-25)), "twenty-five")
  expect_equal(log(cardinal(exp(1))), "one")

  expect_equal(log(ordinal(exp(1))),     "first")
  expect_equal(log(numerator(100), 10),  "two")
  expect_equal(log(denominator(exp(1))), "whole")
  expect_equal(log(adverbial(exp(1))),   "once")
  expect_equal(log(collective(exp(1))),  "the")
})

test_that("Summary", {
  expect_true(all(cardinal(1:5)))
  expect_true(any(cardinal(0:5)))
  expect_false(all(cardinal(0:5)))
  expect_false(any(cardinal(0)))

  expect_equal(sum(cardinal(1:3)),  "six")
  expect_equal(prod(cardinal(1:3)), "six")

  expect_equal(min(cardinal(1:3)),   "one")
  expect_equal(max(cardinal(1:3)),   "three")
  expect_equal(range(cardinal(1:3)), c("one", "three"))

  expect_equal(sum(ordinal(1:3)),     "sixth")
  expect_equal(sum(numerator(1:3)),   "six")
  expect_equal(sum(denominator(1:3)), "sixth")
  expect_equal(sum(adverbial(1:3)),   "six times")
  expect_equal(sum(collective(1:3)),  "all six")
})

test_that("Ops", {
  expect_equal(+cardinal(25), "twenty-five")
  expect_equal(-cardinal(25), "negative twenty-five")

  expect_equal(cardinal(25) + 2,   "twenty-seven")
  expect_equal(cardinal(25) - 2,   "twenty-three")
  expect_equal(cardinal(25) * 2,   "fifty")
  expect_equal(cardinal(25) / 2,   "twelve and one half")
  expect_equal(cardinal(25) ^ 2,   "six hundred twenty-five")
  expect_equal(cardinal(25) %% 2,  "one")
  expect_equal(cardinal(25) %/% 2, "twelve")

  expect_equal(cardinal(1) & TRUE,  TRUE)
  expect_equal(cardinal(1) & FALSE, FALSE)
  expect_equal(cardinal(0) & TRUE,  FALSE)
  expect_equal(cardinal(0) & FALSE, FALSE)
  expect_equal(cardinal(1) | TRUE,  TRUE)
  expect_equal(cardinal(1) | FALSE, TRUE)
  expect_equal(cardinal(0) | TRUE,  TRUE)
  expect_equal(cardinal(0) | FALSE, FALSE)
  expect_equal(!cardinal(1), FALSE)
  expect_equal(!cardinal(0), TRUE)

  expect_true(cardinal(25) == "twenty-five")
  expect_true(cardinal(25) == 25)
  expect_true(cardinal(25) == 25L)
  expect_true(cardinal(1)  == TRUE)
  expect_true(cardinal(0)  == FALSE)

  expect_true(cardinal(24) != "twenty-five")
  expect_true(cardinal(24) != 25)
  expect_true(cardinal(24) != 25L)
  expect_true(cardinal(24) != TRUE)
  expect_true(cardinal(24) != FALSE)

  expect_true(cardinal(25) == cardinal(25))
  expect_true(cardinal(24) <  cardinal(25))
  expect_true(cardinal(24) <= cardinal(25))
  expect_true(cardinal(25) <= cardinal(25))
  expect_true(cardinal(25) >= cardinal(24))
  expect_true(cardinal(25) >= cardinal(25))
  expect_true(cardinal(25) >  cardinal(24))

  expect_false(cardinal(25) < 25)

  expect_equal(ordinal(25) + 2,     "twenty-seventh")
  expect_equal(numerator(25) + 2,   "twenty-seven")
  expect_equal(denominator(25) + 2, "twenty-seventh")
  expect_equal(adverbial(25) + 2,   "twenty-seven times")
  expect_equal(collective(25) + 2,  "all twenty-seven")
})

test_that("nombres pass args", {
  expect_equal(cardinal(100, max_n = 10) + 0,    "100")
  expect_equal(cardinal(-1, negative = "minus"), "minus one")

  expect_equal(ordinal(1, cardinal = FALSE), "1st")

  expect_equal(numerator(-1, negative = "minus"), "minus one")

  expect_equal(denominator(2, 2) + 0,               "halves")
  expect_equal(denominator(4, quarter = FALSE) + 0, "fourth")

  expect_equal(adverbial(3, thrice = TRUE) + 0, "thrice")

  expect_equal(collective(3, all_n = FALSE),                "all")
  expect_equal(collective(3, cardinal = FALSE),             "all 3")
  expect_equal(collective(3, of_the = TRUE),                "all three of the")
  expect_equal(collective(3, all_n = FALSE, of_the = TRUE), "all of the")
})
