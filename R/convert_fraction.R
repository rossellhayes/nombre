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

  na <- apply(x, 2, function(x) all(is.na(x)))

  x[, !na] <- cardinal(
    x[, !na],
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

  result      <- character(ncol(x))
  result[!na] <- paste(x[1, !na], sep, x[2, !na])
  result[na]  <- x[1, na]
  result
}

is_NAish <- function(x) {
  is.na(x) | x == "NaN"
}
