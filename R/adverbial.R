#' Convert numbers to adverbial character vectors (once, twice, three times)
#'
#' @param x A numeric vector
#' @param thrice A logical of length one.
#'     If `TRUE`, the adverbial of `3` will be "thrice".
#'     If `FALSE`, the adverbial of `3` will be "three times".
#'     Defaults to `FALSE`.
#' @param cardinal Whether to convert a numeric vector with [cardinal()]
#'     before applying adverbial suffixes.
#'     When `TRUE`, 1 -> "once".
#'     When `FALSE`, 1 -> "1 time".
#'     Defaults to `TRUE`.
#' @param max_n A numeric vector.
#'     When the absolute value of `x` is greater than `max_n`, `x` remains
#'     numeric instead of being converted to words.
#'     If `max_n` is negative, no `x`s will be converted to words.
#'     Defaults to `Inf`, which converts all `x`s to words.
#' @param ... Additional arguments passed to [cardinal()]
#'
#' @return A character vector of the same length as `x`
#' @family number names
#' @export
#' @example examples/adverbial.R

adverbial <- function(x, thrice = FALSE, cardinal = TRUE, max_n = Inf, ...) {
  if (!length(x))                 return(character(0))
  if (all(is.na(x) & !is.nan(x))) return(as.character(x))
  if (!is.numeric(x))             stop("`x` must be a numeric vector")
  if (length(thrice) != 1)        stop("`thrice` must be length one")
  if (!is.logical(thrice) | is.na(thrice))
    stop("`thrice` must be either `TRUE` or `FALSE`")

  numeric <- x
  na <- is.na(x)

  if (cardinal) {
    x <- cardinal(x, max_n = max_n, ...)
  } else {
    x <- format(x, scientific = FALSE)
  }

  times <- rep("times", length(x))
  times[abs(numeric) == 1] <- "time"
  adv <- paste(x, times)

  if (cardinal && max_n >= 1) {
    adv[!na & abs(numeric) == 1] <- str_replace_all(
      adv[!na & abs(numeric) == 1], "one time$", "once"
    )

    if (max_n >= 2) {
      adv[!na & abs(numeric) == 2] <- str_replace_all(
        adv[!na & abs(numeric) == 2], "two times$", "twice"
      )

      if (thrice && max_n >= 3) {
        adv[!na & abs(numeric) == 3] <- str_replace_all(
          adv[!na & abs(numeric) == 3], "three times$", "thrice"
        )
      }
    }
  }

  adv[na] <- NA
  adv[is.nan(numeric)] <- NaN

  args <- as.list(match.call()[-1])
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
