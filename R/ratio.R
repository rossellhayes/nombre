#' Convert numbers to ratio character vectors (two to one, one in three, five out of ten)
#'
#' @param x A numeric vector
#'     Defaults to `"to"`.
#' @param sep A character vector separating components of the ratio.
#'     Default can be changed with [set_config("nombre::sep")][set_config()].
#' @param common_denom Logical. If TRUE, all ratios use a common denominator
#'     value. If FALSE, a denominator of 1 is used when `x` is 0. Default can be
#'     changed with [set_config("nombre::common_denom")][set_config()].
#' @param ... Additional arguments passed to [fracture::frac_mat()].
#'     See details.
#' @inheritParams cardinal
#'
#' @details
#'
#' `x` is converted to a fraction by [fracture::frac_mat()].
#' Named arguments of `ratio()` and `nom_ratio()` are passed to
#' [fracture::frac_mat()] through `...`.
#' Helpful arguments include:
#' * `base_10 = TRUE`, which forces all fractions to use denominators that are
#'   powers of ten.
#' * `max_denom`, which sets the maximum allowable denominator.
#'   By default, the maximum denominator is "ten-millionths".
#'
#' The [fracture::frac_mat()]  argument `mixed` is set to TRUE.
#'
#' @return A character vector of the same length as `x`
#' @family number names
#' @export
#' @example examples/ratio.R

ratio <- function(
  x,
  sep       = get_config("nombre::sep", "to"),
  max_n     = get_config("nombre::max_n", Inf),
  negative  = get_config("nombre::negative", "negative"),
  common_denom = get_config("nombre::common_denom", FALSE),
  ...
) {
  numeric <- x
  n       <- length(x)

  if (!n)                 return(character(0))
  if (!is.numeric(x))     stop("`x` must be numeric")
  if (!is.numeric(max_n)) stop("`max_n` must be numeric")
  if (length(max_n) != 1 && length(max_n) != n)
    stop("`max_n` must be either length one or the same length as `x`")
  if (!is.character(negative)) stop("`negative` must be of type character")
  if (length(negative) != 1 && length(negative) != n)
    stop("`negative` must be length one or the same length as `x`")

  ratio                 <- character(n)
  ratio[abs(x) > max_n] <- as.character(x[abs(x) > max_n])

  unmaxed <- ratio == character(1)

  minus                  <- character(n)
  minus[x < 0 & unmaxed] <- paste0(negative, " ")
  x[unmaxed]             <- abs(x[unmaxed])

  if (any(unmaxed)) {
    ratio[unmaxed] <- convert_fraction(x[unmaxed], sep, mixed = FALSE, common_denom = common_denom, ...)
    ratio <- paste0(minus, ratio)
  }

  args        <- as.list(match.call()[-1])
  args[["x"]] <- NULL

  structure(
    ratio,
    numeric = numeric,
    nombre  = "ratio",
    args    = args,
    class   = c("nombre", "character")
  )
}

#' @rdname ratio
#' @export

nom_ratio <- ratio
