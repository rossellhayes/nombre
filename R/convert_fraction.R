convert_fraction <- function(x) {
  if (!length(x)) return(character(0))

  x           <- vapply(x, decimal_to_fraction, integer(2))
  numerator   <- numerator(x[1, ])
  denominator <- denominator(x[2, ], x[1, ])

  paste(numerator, denominator)
}
