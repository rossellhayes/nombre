#' Convert numbers to ordinal character vectors
#'
#' @param x A numeric vector
#' @param numerator A numeric vector.
#'     The numerator(s) associated with the denominator(s).
#'     When `numerator` is `1` or `-1`, returns a singular denominator.
#'     When `numerator` is not `1` or `-1`, returns a plural denominator.
#' @param quarter A logical of length one.
#'     If `TRUE`, the denominator of `4` will be "quarter(s)".
#'     If `FALSE`, the denominator of `4` will be "fourth(s)".
#'     Defaults to `TRUE`.
#'     Default can be changed by setting `options("nombre.quarter")`.
#' @param negative A character of length one to append to negative numbers.
#'     Defaults to `"negative"`.
#'     Default can be changed by setting `options("nombre.negative")`.
#'
#' @return A character vector of the same length as `x`
#' @export
#'
#' @example examples/denominator.R

denominator <- function(
  x, numerator = 1, quarter = getOption("nombre.quarter", TRUE),
  negative = getOption("nombre.negative", "negative")
) {
  if (!length(x))              return(character(0))
  if (!is.numeric(x))          stop("`x` must be numeric")
  if (!is.character(negative)) stop("`negative` must be of type character")
  if (length(negative) != 1)   stop("`negative` must be length one")
  if (!is.numeric(numerator))  stop("`numerator` must be numeric")
  if (length(numerator) != 1 & length(numerator) != length(x))
    stop("`numerator` must be either length one or the same length as `x`")
  if (!is.logical(quarter) | length(quarter) != 1 | is.na(quarter))
    stop("`quarter` must be either `TRUE` or `FALSE`")

  denom  <- rep("", length(x))
  plural <- abs(numerator) != 1

  denom[abs(x) == 1] <- "whole"

  denom[abs(x) == 2 & !plural] <- "half"
  denom[abs(x) == 2 & plural]  <- "halves"

  if (quarter) denom[abs(x) == 4] <- "quarter"

  denom[x < 0 & denom != ""]  <- paste(negative, denom[x < 0 & denom != ""])
  denom[denom == ""]          <- ordinal(x[denom == ""], negative = negative)
  denom[plural & abs(x) != 2] <- paste0(denom[plural & abs(x) != 2], "s")

  denom
}

#' @rdname denominator
#' @export

nom_denom <- denominator
