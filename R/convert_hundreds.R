convert_hundreds <- function(x) {
  if (!length(x)) return(character(0))

  hundreds_place <- tens_place <- ones_place <- dash <- rep("", length(x))

  class(x)    <- "numeric"
  x[is.na(x)] <- 0

  hundreds_place[x >= 100] <- paste0(digits[x[x >= 100] %/% 100], " hundred ")
  x                        <- x %% 100

  tens_place[x >= 20] <- tens[x[x >= 20] %/% 10]
  x[x >= 20]          <- x[x >= 20] %% 10

  ones_place[x > 0] <- digits[x[x > 0]]

  dash[tens_place != "" & ones_place != ""] <- "-"

  x[] <- trimws(paste0(hundreds_place, tens_place, dash, ones_place))
  x
}
