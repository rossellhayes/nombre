convert_fraction <- function(x, frac_args) {
  if (!length(x)) return(character(0))

  x           <- do.call(fracture::frac_mat, c(list(x), frac_args))
  numerator   <- numerator(x[1, ])
  denominator <- denominator(x[2, ], x[1, ])

  paste(numerator, denominator)
}
