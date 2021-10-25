#' Convert numbers to ratio character vectors (two to one, one in three, five out of ten)
#'
#' @param x A numeric vector
#' @param sep A character vector separating components of the ratio.
#'     Defaults to `"in"`.
#'     Default can be changed with [set_config("nombre::sep")][set_config()].
#' @inheritDotParams fracture::frac_mat -mixed
#' @inheritParams cardinal
#'
#' @details
#' `x` is converted to a fraction by [fracture::frac_mat()].
#'
#' @return A character vector of the same length as `x`
#' @family number names
#' @export
#' @example examples/ratio.R

ratio <- function(
  x,
  sep       = get_config("nombre::sep", "in"),
  max_n     = get_config("nombre::max_n", Inf),
  negative  = get_config("nombre::negative", "negative"),
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

  ratio <- convert_fraction(
    x, sep, max_n = max_n, negative = negative, mixed = FALSE, ...
  )

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
