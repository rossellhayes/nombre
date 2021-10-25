#' Convert numbers to adverbial character vectors (once, twice, three times)
#'
#' @param x A numeric vector
#' @param thrice A logical of length one.
#'     If `TRUE`, the adverbial of `3` will be "thrice".
#'     If `FALSE`, the adverbial of `3` will be "three times".
#'     Defaults to `FALSE`.
#' @param ... Additional arguments passed to [cardinal()]
#'
#' @return A character vector of the same length as `x`
#' @family number names
#' @export
#' @example examples/adverbial.R

adverbial <- function(x, thrice = FALSE, ...) {
  if (!length(x))          return(character(0))
  if (!is.numeric(x))      stop("`x` must be a numeric vector")
  if (length(thrice) != 1) stop("`thrice` must be length one")
  if (!is.logical(thrice) | is.na(thrice))
    stop("`thrice` must be either `TRUE` or `FALSE`")

  numeric <- x

  adv              <- paste(cardinal(x, ...), "time")
  adv[abs(x) != 1] <- paste0(adv[abs(x) != 1], "s")

  adv[abs(x) == 1] <- gsub("one time$", "once", adv[abs(x) == 1])
  adv[abs(x) == 2] <- gsub("two times$", "twice", adv[abs(x) == 2])

  if (thrice) {
    adv[abs(x) == 3] <- gsub("three times$", "thrice", adv[abs(x) == 3])
  }

  args        <- as.list(match.call()[-1])
  args[["x"]] <- NULL

  structure(
    adv,
    numeric = numeric,
    nombre  = "adverbial",
    args    = args,
    class   = c("nombre", "character")
  )
}

#' @rdname adverbial
#' @export

nom_adv <- adverbial

#' @rdname adverbial
#' @export

nom_times <- adverbial
