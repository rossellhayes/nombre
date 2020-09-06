#' Convert numbers to numerator character vectors (one, two, three)
#'
#' `nom_numer()` and `numerator()` are equivalent to [nom_card()] and
#' [cardinal()] for integers, but [cardinal]s support fractional components
#' while `numerator`s do not.
#'
#' @param x A numeric vector
#' @param ... Additional arguments passed to [cardinal()]
#'
#' @family number names
#' @export

numerator <- function(x, ...) {
  structure(cardinal(x, ..., numerator = TRUE), nombre = "numerator")
}

#' @rdname numerator
#' @export

nom_numer <- numerator
