#' Convert numbers to collective character vectors (the, both, all three)
#'
#' @param x A numeric vector.
#' @param all_n Whether to include the cardinal number after "all" for
#'     collectives of 3 or more.
#'     Defaults to `TRUE`.
#'     Default can be changed with [set_config("nombre::all_n")][set_config()].
#' @param of_the Whether to include "of the" for collectives other than 1.
#'     Defaults to `FALSE`.
#'     Default can be changed with [set_config("nombre::of")][set_config()].
#' @param cardinal Whether to convert the number after "all" with [cardinal()]
#'     when `all_n` is `TRUE`.
#'     Defaults to `TRUE`.
#'     Default can be changed with
#'     [set_config("nombre::coll_cardinal")][set_config()].
#' @param ... Additional arguments passed to [cardinal()] when `cardinal`
#'     is `TRUE`.
#'
#' @return A character vector of the same length as `x`.
#' @family number names
#' @export
#' @example examples/collective.R

collective <- function(
  x,
  all_n    = get_config("nombre::all_n", TRUE),
  of_the   = get_config("nombre::of_the", FALSE),
  cardinal = get_config("nombre::coll_cardinal", TRUE),
  ...
) {
  if (!length(x))     return(character(0))
  if (!is.numeric(x)) stop("`x` must be a numeric vector")

  numeric <- x

  coll <- of <- n <- card <- character(length(x))

  coll[x == 1] <- "the"
  coll[x == 2] <- "both"

  if (of_the) {
    coll[x == 0] <- "none"
    of[x != 1]   <- " of the"
  } else {
    coll[x == 0] <- "no"
  }

  if (all_n) {
    if (cardinal) {
      card[coll == ""] <- cardinal(x[coll == ""], ...)
    } else {
      card[coll == ""] <- format(x[coll == ""], scientific = FALSE)
    }

    n[coll == ""] <- paste0(" ", card[coll == ""])
  }

  coll[coll == ""] <- "all"

  coll <- paste0(coll, n, of)

  args        <- as.list(match.call()[-1])
  args[["x"]] <- NULL

  structure(
    coll,
    numeric = numeric,
    nombre  = "collective",
    args    = args,
    class   = c("nombre", "character")
  )
}

#' @rdname collective
#' @export

nom_coll <- collective
