convert_fraction <- function(x, ...) {
  if (!length(x)) return(character(0))

  x           <- fracture::frac_mat(x, ...)
  numerator   <- numerator(x[1, ])
  denominator <- denominator(x[2, ], x[1, ])

  paste(numerator, denominator)
}
