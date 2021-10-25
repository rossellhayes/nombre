expect_equal <- function(...) {
  testthat::expect_equal(..., ignore_attr = TRUE)
}
