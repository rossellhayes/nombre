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
  if (!length(x))                 return(character(0))
  if (all(is.na(x) & !is.nan(x))) return(as.character(x))
  if (!is.numeric(x))             stop("`x` must be a numeric vector")
  if (length(thrice) != 1)        stop("`thrice` must be length one")
  if (!is.logical(thrice) | is.na(thrice))
    stop("`thrice` must be either `TRUE` or `FALSE`")

  numeric <- x
  na      <- is.na(x)

  adv                    <- paste(cardinal(x, ...), "time")
  adv[!na & abs(x) != 1] <- paste0(adv[!na & abs(x) != 1], "s")

  adv[!na & abs(x) == 1] <- gsub("one time$", "once", adv[!na & abs(x) == 1])
  adv[!na & abs(x) == 2] <- gsub("two times$", "twice", adv[!na & abs(x) == 2])

  if (thrice) {
    adv[!na & abs(x) == 3] <- gsub(
      "three times$", "thrice", adv[!na & abs(x) == 3]
    )
  }

  adv[is.na(x)]  <- NA
  adv[is.nan(x)] <- NaN

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
