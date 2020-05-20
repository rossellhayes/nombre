#' Convert numbers to cardinal character vectors (one, two, three)
#'
#' `nom_card()` and `cardinal()` produce cardinal numbers.
#' `nom_numer()` and `numerator()` produce numerators.
#' The results are equivalent for integers, but `nom_card()` and `cardinal()`
#' support fractional components while `nom_numer()` and `numerator()` do not.
#'
#' @param x A numeric vector
#' @param max_n A numeric vector.
#'     When `x` is greater than `max_n`, `x` remains numeric instead of
#'     being converted to words.
#'     Defaults to `Inf`, which converts all `x`s to words.
#'     Default can be changed by setting `options("nombre.max_n")`.
#' @param negative A character vector to append to negative numbers.
#'     Defaults to `"negative"`.
#'     Default can be changed by setting `options("nombre.negative")`.
#' @param numerator When `TRUE`, an error is produced if `x` has a decimal or
#'     fractional component.
#'     Defaults to `FALSE`.
#'
#' @return A character vector of the same length as `x`
#' @family number names
#' @export
#' @example examples/cardinal.R

cardinal <- function(
  x,
  max_n     = getOption("nombre.max_n", Inf),
  negative  = getOption("nombre.negative", "negative"),
  numerator = FALSE
) {
  n <- length(x)

  if (!n)                      return(character(0))
  if (!is.numeric(x))          stop("`x` must be numeric")
  if (!is.numeric(max_n))      stop("`max_n` must be numeric")
  if (length(max_n) != 1 & length(max_n) != n)
    stop("`max_n` must be either length one or the same length as `x`")
  if (!is.character(negative)) stop("`negative` must be of type character")
  if (length(negative) != 1 & length(negative) != n)
    stop("`negative` must be length one or the same length as `x`")
  if (numerator & any(x != as.integer(x)))
    stop("`x` cannot have a decimal component when `numerator` is TRUE")
  if (any(x != as.integer(x) & !requireNamespace("MASS", quietly = TRUE))) {
    stop(
      strwrap(
        'The MASS package is required to use nombre with non-integer inputs.',
        paste(
          'Either run `install.packages("MASS")`',
          'or use only inputs with no decimal component.'
        )
      )
    )
  }

  card                      <- character(n)
  card[abs(x) > abs(max_n)] <- as.character(x[abs(x) > abs(max_n)])

  unmaxed <- card == ""
  if (!any(unmaxed)) return(card)

  minus                  <- character(n)
  minus[x < 0 & unmaxed] <- paste0(negative, " ")
  x[unmaxed]             <- abs(x[unmaxed])

  decimal          <- numeric(n)
  decimal[unmaxed] <- x[unmaxed] %% 1
  if (any(decimal != 0) & !requireNamespace("MASS", quietly = TRUE)) {
    stop(
      paste(
        'The MASS package is required to use the nombre package with',
        'non-integer inputs. Either run `install.packages("MASS")` or use only',
        'inputs with no decimal or fractional component.'
      )
    )
  }
  fraction               <- character(n)
  fraction[decimal != 0] <- convert_fraction(decimal[decimal != 0])
  x[unmaxed]             <- x[unmaxed] %/% 1

  x[unmaxed] <- format(x[unmaxed], scientific = FALSE)
  nchar      <- ceiling(nchar(x[unmaxed][[1]]) / 3) * 3
  x[unmaxed] <- format(
    x[unmaxed], justify = "right", width = nchar, scientific = FALSE
  )

  n_unmaxed <- sum(unmaxed)

  segment <- matrix(rep(x[unmaxed], nchar / 3), ncol = n_unmaxed, byrow = TRUE)
  segment <- substr(
    segment, rep(seq(1, nchar, 3), n_unmaxed), rep(seq(3, nchar, 3), n_unmaxed)
  )
  segment <- convert_hundreds(segment)

  nrow                 <- nrow(segment)
  power                <- segment
  power[]              <- rep(powers[seq_len(nrow)], n_unmaxed)
  power                <- power[nrow:1, ]
  power[segment == ""] <- ""

  segment[]                         <- paste0(segment, power)
  card[unmaxed]                     <- apply(segment, 2, paste, collapse = "")
  card[card == "" & fraction == ""] <- "zero"

  and                              <- character(n)
  and[card != "" & fraction != ""] <- " and "

  card <- paste0(minus, trimws(card), and, fraction)
  card
}

#' @rdname cardinal
#' @export

nom_card <- cardinal

#' @rdname cardinal
#' @export

numerator <- function(
  x,
  max_n     = getOption("nombre.max_n", Inf),
  negative  = getOption("nombre.negative", "negative")
) {
  cardinal(x, max_n, negative, numerator = TRUE)
}

#' @rdname cardinal
#' @export

nom_numer <- numerator
