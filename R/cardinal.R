#' Convert numbers to cardinal character vectors (one, two, three)
#'
#' @param x A numeric vector
#' @param max_n A numeric vector.
#'     When the absolute value of `x` is greater than `max_n`, `x` remains
#'     numeric instead of being converted to words.
#'     If `max_n` is negative, no `x`s will be converted to words.
#'     (This can be useful when `max_n` is passed by another function.)
#'     Defaults to `Inf`, which converts all `x`s to words.
#' @param negative A character vector to append to negative numbers.
#'     Defaults to `"negative"`.
#' @inheritDotParams fracture::frac_mat -mixed
#'
#' @details # Fractions
#'
#' Decimal components of `x` are automatically converted to fractions by
#' [fracture::frac_mat()].
#'
#' @return A character vector of the same length as `x`
#' @family number names
#' @seealso [uncardinal()] to convert character vectors to numbers
#' @export
#' @example examples/cardinal.R

cardinal <- function(x, max_n = Inf, negative = "negative", ...) {
  numeric <- x
  n       <- length(x)

  if (!n)                 return(character(0))
  if (!is.numeric(x))     stop("`x` must be numeric")
  if (!is.numeric(max_n)) stop("`max_n` must be numeric")
  if (length(max_n) != 1 && length(max_n) != n)
    stop("`max_n` must be either length one or the same length as `x`")
  if (!is.character(negative)) stop("`negative` must be of type character")

  if (length(negative) == 1) {
    negative <- rep_len(negative, length(x))
  }
  if (length(negative) != n)
    stop("`negative` must be length one or the same length as `x`")

  card                 <- character(n)
  card[abs(x) > max_n] <- gsub(
    " ", "", format(x[abs(x) > max_n], scientific = FALSE)
  )

  unmaxed <- card == character(1)

  minus                  <- character(n)
  minus[x < 0 & unmaxed] <- paste0(negative[x < 0 & unmaxed], " ")
  x[unmaxed]             <- abs(x[unmaxed])

  if (any(unmaxed)) {
    decimal                <- numeric(n)
    decimal[unmaxed]       <- x[unmaxed] %% 1
    fraction               <- character(n)
    fraction[decimal != 0] <- convert_fraction(decimal[decimal != 0], ...)
    x[unmaxed]             <- x[unmaxed] %/% 1

    x[unmaxed] <- format(x[unmaxed], scientific = FALSE)
    nchar      <- ceiling(nchar(x[unmaxed][[1]]) / 3) * 3
    x[unmaxed] <- format(
      x[unmaxed], justify = "right", width = nchar, scientific = FALSE
    )

    n_unmaxed <- sum(unmaxed)

    segment <- matrix(
      rep(x[unmaxed], nchar / 3), ncol = n_unmaxed, byrow = TRUE
    )
    segment <- substr(
      segment,
      rep(seq(1, nchar, 3), n_unmaxed),
      rep(seq(3, nchar, 3), n_unmaxed)
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
  }

  args        <- as.list(match.call()[-1])
  args[["x"]] <- NULL

  structure(
    card,
    numeric = numeric,
    nombre  = "cardinal",
    args    = args,
    class   = c("nombre", "character")
  )
}

#' @rdname cardinal
#' @export

nom_card <- cardinal
