convert_fraction <- function(x) {
  if (!length(x)) return(character(0))

  x           <- vapply(x, decimal_to_fraction, numeric(2))
  numerator   <- numerator(x[1, ])
  denominator <- denominator(x[2, ], x[1, ])

  paste(numerator, denominator)
}

decimal_to_fraction <- function(x) {
  stopifnot(0 <= x & x <= 1)

  a <- a_left <- a_save <- 0
  a_right <- b <- b_left <- b_right <- b_save <- 1

  while (abs(x - a_save / b_save) > sqrt(.Machine$double.eps)) {
    if (abs(x - a / b) < abs(x - a_save / b_save)) {
      a_save <- round(a)
      b_save <- b
    }

    b <- b_left + b_right
    a <- a_left + a_right

    if (x * b < a) {
      a_right <- a
      b_right <- b
    } else {
      a_left <- a
      b_left <- b
    }
  }

  matrix(c(a_save, b_save))
}
