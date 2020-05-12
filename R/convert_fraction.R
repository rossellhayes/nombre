convert_fraction <- function(x) {
  if (!length(x)) return(character(0))

  x           <- as.character(MASS::fractions(x))
  x[x == "0"] <- "0/0"
  x           <- strsplit(x, "/")
  x           <- matrix(as.numeric(unlist(x)), ncol = length(x))
  numerator   <- cardinal(x[1, ])
  denominator <- denominator(x[2, ], x[1, ])

  paste(numerator, denominator)
}
