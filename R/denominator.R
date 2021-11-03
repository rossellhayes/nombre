#' Convert numbers to denominator character vectors (whole, half, third)
#'
#' @param x A numeric vector
#' @param numerator A numeric vector.
#'     The numerator(s) associated with the denominator(s).
#'     When `numerator` is not `1` or `-1`, the denominator will be pluralized.
#' @param quarter A logical of length one.
#'     If `TRUE`, the denominator of `4` will be "quarter(s)".
#'     If `FALSE`, the denominator of `4` will be "fourth(s)".
#'     Defaults to `TRUE`.
#' @param ... Additional arguments passed to [ordinal()]
#'
#' @return A character vector of the same length as `x`
#' @family number names
#' @export
#' @example examples/denominator.R

denominator <- function(x, numerator = 1, quarter = TRUE, ...) {
  if (!length(x))                 return(character(0))
  if (all(is.na(x) & !is.nan(x))) return(as.character(x))
  if (!is.numeric(x))             stop("`x` must be numeric")
  if (!is.numeric(numerator))     stop("`numerator` must be numeric")
  if (length(numerator) != 1 & length(numerator) != length(x))
    stop("`numerator` must be either length one or the same length as `x`")
  if (length(quarter) != 1) stop("`quarter` must be length one")
  if (!is.logical(quarter) | is.na(quarter))
    stop("`quarter` must be either `TRUE` or `FALSE`")

  numeric <- x
  finite  <- is.finite(x)
  denom   <- ordinal(x, ...)
  plural  <- abs(numerator) != 1

  denom[finite & abs(x) == 1] <- gsub(
    "1st$|first$", "whole", denom[finite & abs(x) == 1]
  )

  denom[finite & abs(x) == 2 & !plural] <- gsub(
    "2nd$|second$", "half", denom[finite & abs(x) == 2 & !plural]
  )
  denom[finite & abs(x) == 2 & plural] <- gsub(
    "2nd$|second$", "halves", denom[finite & abs(x) == 2 & plural]
  )

  if (quarter) {
    denom[finite & abs(x) == 4] <- gsub(
      "fourth$", "quarter", denom[finite & abs(x) == 4]
    )
  }

  denom[finite & plural & abs(x) != 2] <- paste0(
    denom[finite & plural & abs(x) != 2], "s"
  )

  denom <- gsub("^one-", "", denom)

  denom[is.na(x)]  <- NA
  denom[is.nan(x)] <- NaN

  args        <- as.list(match.call()[-1])
  args[["x"]] <- NULL

  structure(
    denom,
    numeric = numeric,
    nombre  = "denominator",
    args    = args,
    class   = c("nombre", "character")
  )
}

#' @rdname denominator
#' @export

nom_denom <- denominator
