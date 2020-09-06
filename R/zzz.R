expect_equal <- function(
  object, expected, ..., info = NULL, label = NULL, expected.label = NULL
) {
  act <- testthat::quasi_label(
    rlang::enquo(object), label, arg = "object"
  )

  exp <- testthat::quasi_label(
    rlang::enquo(expected), expected.label, arg = "expected"
  )

  comp <- waldo::compare(
    act$val, exp$val,
    ..., ignore_attr = TRUE, x_arg = "actual", y_arg = "expected"
  )

  testthat::expect(
    length(comp) == 0,
    sprintf(
      "%s (%s) not equal to %s (%s).\n\n%s",
      act$lab, "`actual`",
      exp$lab, "`expected`",
      paste0(comp, collapse = "\n\n")
    ),
    info = info
  )

  invisible(act$val)
}
