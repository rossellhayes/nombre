convert_fraction <- function(x, sep, ...) {
  if (!length(x)) return(character(0))

  x           <- fracture::frac_mat(x, ...)
  numerator   <- numerator(x[1, ])

  if (is.null(sep)) {
    denominator <- denominator(x[2, ], x[1, ])
    paste(numerator, denominator)
  } else {
    denominator <- numerator(x[2, ])
    paste(numerator, sep, denominator)
  }
}
