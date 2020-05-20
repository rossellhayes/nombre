#' Convert numbers to collective character vectors (the, both, all three)
#'
#' @param x A numeric vector
#' @param ... Additional arguments passed to [cardinal()]
#'
#' @return A character vector of the same length as `x`
#' @family number names
#' @export
#' @example examples/collective.R

collective <- function(x, ...) {
  if (!length(x))     return(character(0))
  if (!is.numeric(x)) stop("`x` must be a numeric vector")

  coll             <- character(length(x))
  coll[x == 1]     <- "the"
  coll[x == 2]     <- "both"
  coll[coll == ""] <- paste("all", cardinal(x[coll == ""], ...))
  coll
}

#' @rdname collective
#' @export

nom_coll <- collective
