#' Convert numbers to collective character vectors (the, both, all three)
#'
#' @param x A numeric vector.
#' @param of_the Whether to include "of the" for collectives other than 1.
#'     Defaults to `FALSE`.
#'     Default can be changed with [set_config("nombre::of")][set_config()].
#' @param ... Additional arguments passed to [cardinal()].
#'
#' @return A character vector of the same length as `x`.
#' @family number names
#' @export
#' @example examples/collective.R

collective <- function(x, all_n = get_config("nombre::all_n", TRUE), of_the = get_config("nombre::of_the", FALSE), ...) {
  if (!length(x))     return(character(0))
  if (!is.numeric(x)) stop("`x` must be a numeric vector")

  coll <- of <- n  <- character(length(x))

  coll[x == 1]     <- "the"
  coll[x == 2]     <- "both"

  if (of_the) {
    coll[x == 0] <- "none"
    of[x != 1]   <- " of the"
  } else {
    coll[x == 0] <- "no"
  }

  if (all_n) {n[coll == ""] <- paste0(" ", cardinal(x[coll == ""], ...))}

  coll[coll == ""] <- "all"

  coll <- paste0(coll, n, of)

  structure(
    coll, nombre = "collective", numeric = x, class = c("nombre", "character")
  )
}

#' @rdname collective
#' @export

nom_coll <- collective
