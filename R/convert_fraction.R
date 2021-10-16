convert_fraction <- function(
  x, sep = NULL, max_n = Inf, negative = "negative", ...
) {
  if (!length(x)) return(character(0))

  x <- fracture::frac_mat(x, ...)

  if (is.null(sep)) {
    numerator   <- numerator(x[1, ], max_n = max_n, negative = negative)
    denominator <- denominator(x[2, ], x[1, ], max_n = max_n)
    return(paste(numerator, denominator))
  }

  x[] <- cardinal(
    x,
    max_n = if (length(max_n) == 1) {
      max_n
    } else {
      rep(max_n, each = length(x) / 2)
    },
    negative = if (length(negative) == 1) {
      negative
    } else {
      rep(negative, each = length(x) / 2)
    }
  )
  paste(x[1, ], sep, x[2, ])
}
