#' Convert numbers to cardinal character vectors
#'
#' `cardinal()` and `nmr_card()` produce cardinal numbers.
#' `numerator()` and `nmr_num()` produce numerators.
#' The results are equivalent for integers, but `cardinal()` and `nmr_card()`
#' support fractional components while `numerator()` and `nmr_num()` do not.
#'
#' @param x A numeric vector
#' @param negative A character to append to negative numbers.
#'     Defaults to `"negative"`.
#'     Default can be changed by setting `options("numerate.negative")`.
#'
#' @return A character vector of the same length as `x`
#' @export
#'
#' @example examples/cardinal.R

cardinal <- function(x, negative = getOption("numerate.negative", "negative")) {
  if (!length(x))              return(character(0))
  if (!is.numeric(x))          stop("`x` must be numeric")
  if (!is.character(negative)) stop("`negative` must be of type character")
  if (length(negative) != 1)   stop("`negative` must be length one")

  length <- length(x)

  minus        <- rep("", length)
  minus[x < 0] <- paste0(negative, " ")
  x            <- abs(x)

  decimal                <- x %% 1
  if (any(decimal != 0) & !requireNamespace("MASS", quietly = TRUE)) {
    stop(
      paste(
        "The MASS package is required to use the numerate package with",
        "non-integer inputs. Either run `install.packages(MASS)` or use only",
        "integer inputs."
      )
    )
  }
  fraction               <- rep("", length)
  fraction[decimal != 0] <- convert_fraction(decimal[decimal != 0])
  x                      <- x %/% 1

  x      <- format(x, scientific = FALSE)
  nchar  <- ceiling(nchar(x[[1]]) / 3) * 3
  x      <- format(x, justify = "right", width = nchar, scientific = FALSE)

  segment <- matrix(rep(x, nchar / 3), ncol = length, byrow = TRUE)
  segment <- substr(
    segment, rep(seq(1, nchar, 3), length), rep(seq(3, nchar, 3), length)
  )
  segment <- convert_hundreds(segment)

  nrow    <- nrow(segment)
  power   <- segment
  power[] <- rep(powers[seq_len(nrow)], length)
  power   <- power[nrow:1, ]
  power[segment == ""] <- ""

  segment[]                   <- paste0(segment, power)
  x                           <- apply(segment, 2, paste, collapse = "")
  x[x == "" & fraction == ""] <- "zero"

  and                           <- rep("", length)
  and[x != "" & fraction != ""] <- " and "

  x <- paste0(minus, trimws(x), and, fraction)
  x
}

#' @rdname cardinal
#' @export

nmr_card <- cardinal

#' @rdname cardinal
#' @export

numerator <- function(x, negative = getOption("numerate.negative", "negative")) {
  if (!length(x))         return(character(0))
  if (!is.numeric(x))     stop("`x` must be numeric")
  if (any(x != as.integer(x)))
    stop("`x` must be an integer or a double with no decimal component")
  if (!is.character(negative)) stop("`negative` must be of type character")
  if (length(negative) != 1)   stop("`negative` must be length one")

  length <- length(x)

  minus        <- rep("", length)
  minus[x < 0] <- paste0(negative, " ")
  x            <- abs(x)

  x      <- format(x, scientific = FALSE)
  nchar  <- ceiling(nchar(x[[1]]) / 3) * 3
  x      <- format(x, justify = "right", width = nchar, scientific = FALSE)

  segment <- matrix(rep(x, nchar / 3), ncol = length, byrow = TRUE)
  segment <- substr(
    segment, rep(seq(1, nchar, 3), length), rep(seq(3, nchar, 3), length)
  )
  segment <- convert_hundreds(segment)

  nrow    <- nrow(segment)
  power   <- segment
  power[] <- rep(powers[seq_len(nrow)], length)
  power   <- power[nrow:1, ]
  power[segment == ""] <- ""

  segment[]  <- paste0(segment, power)
  x          <- apply(segment, 2, paste, collapse = "")
  x[x == ""] <- "zero"

  x <- paste0(minus, trimws(x))
  x
}

#' @rdname cardinal
#' @export

nmr_num <- numerator
