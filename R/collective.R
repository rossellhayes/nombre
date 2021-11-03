#' Convert numbers to collective character vectors (the, both, all three)
#'
#' @param x A numeric vector.
#' @param all_n Whether to include the cardinal number after "all" for
#'     collectives of 3 or more.
#'     Defaults to `TRUE`.
#' @param of_the Whether to include "of the" for collectives other than 1.
#'     Defaults to `FALSE`.
#' @param cardinal Whether to convert the number after "all" with [cardinal()]
#'     when `all_n` is `TRUE`.
#'     Defaults to `TRUE`.
#' @param ... Additional arguments passed to [cardinal()] when `cardinal`
#'     is `TRUE`.
#'
#' @return A character vector of the same length as `x`.
#' @family number names
#' @export
#' @example examples/collective.R

collective <- function(x, all_n = TRUE, of_the = FALSE, cardinal = TRUE, ...) {
  if (!length(x))                 return(character(0))
  if (all(is.na(x) & !is.nan(x))) return(as.character(x))
  if (!is.numeric(x))             stop("`x` must be a numeric vector")

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

  coll[is.na(x)]  <- NA
  coll[is.nan(x)] <- NaN

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
